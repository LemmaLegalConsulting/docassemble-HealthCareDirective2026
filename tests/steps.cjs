const path=require('node:path');
const fs=require('node:fs');
const {execFileSync}=require('node:child_process');
const alkiln=process.env.ALKILN_PATH;
const {Then}=require(path.join(alkiln,'node_modules/@cucumber/cucumber'));
const scope=require(path.join(alkiln,'lib/scope'));
// Docassemble now uses div.da-button-set instead of fieldset for these controls.
// Restrict the compatibility change to selectors; keep ALKiln navigation/assertions.
scope.continue_button_selector='.da-field-buttons button[type="submit"].btn-primary';
scope.signature_selector='.da-field-buttons .dasigsave';
// New labels omit aria-checked. Read the associated native input instead.
scope.setCheckbox=async (_scope,{label,answer})=>{
 await label.evaluate((el,want)=>{
  const input=el.control||document.getElementById(el.htmlFor);
  if(!input)throw Error('Checkbox label has no associated input');
  if(input.checked!==want)el.click();
 },String(answer).toLowerCase()==='true');
};
const clean=s=>s.replace(/\s+/g,' ').trim();
Then('the downloaded PDF {string} should contain {string}',async(file,expected)=>{
 const pdf=path.join(scope.paths.scenario,file);
 const text=clean(execFileSync('pdftotext',[pdf,'-'],{encoding:'utf8'}));
 if(!text.includes(clean(expected)))throw Error('Missing PDF text: '+expected);
});
Then('the downloaded PDF {string} should not contain {string}',async(file,unwanted)=>{
 const text=clean(execFileSync('pdftotext',[path.join(scope.paths.scenario,file),'-'],{encoding:'utf8'}));
 if(text.includes(clean(unwanted)))throw Error('Unexpected PDF text: '+unwanted);
});

// Fail promptly on AssemblyLine's custom error screen instead of repeatedly pressing Next.
const examine=scope.examinePageID;
scope.examinePageID=async(...args)=>{
 const result=await examine(...args);
 if(result.id==='custom-error-action')throw Error('Interview runtime error: '+await scope.page.$eval('#daquestion',e=>e.innerText));
 return result;
};
const {When}=require(path.join(alkiln,'node_modules/@cucumber/cucumber'));
When('I follow the review link containing {string}',{timeout:90000},async(text)=>{
 const links=await scope.page.$$('#daquestion a');
 for(const link of links){
  if((await link.evaluate(e=>e.closest('.da-review')?.innerText || e.innerText)).includes(text)){
   await scope.tapElementAndNavigate(scope,{elem:link});return;
  }
 }
 throw Error('No review link containing: '+text);
});

// Resume can change the question without changing the URL on current Docassemble.
// Keep the normal error checks and require an observable question or URL change.
scope.waitUntilContinued=async (state,{url='',id=''})=>{
 const previous=id||state.page_id;
 const deadline=Date.now()+state.timeout;
 while(Date.now()<deadline){
  const error=await state.checkForError(state);
  if(error.was_found)return error;
  const current=await state.get_page_id(state);
  if(state.page.url()!==url || (previous && current && current!==previous))return error;
  await new Promise(resolve=>setTimeout(resolve,50));
 }
 throw Error('No question or URL change after Continue from '+previous);
};

// A navigation can replace the DOM during a read-only error query. Retry that
// query on the new document; never retry an input action or ignore an error.
const checkForError=scope.checkForError;
scope.checkForError=async (...args)=>{
 for(let attempt=0;attempt<5;attempt++){
  try{return await checkForError(...args);}catch(error){
   if(!String(error).includes('Execution context was destroyed')||attempt===4)throw error;
   await new Promise(resolve=>setTimeout(resolve,100));
  }
 }
};
