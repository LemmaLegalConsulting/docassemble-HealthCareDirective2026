from pathlib import Path
from tempfile import TemporaryDirectory
from types import SimpleNamespace
import unittest
from docx import Document
from docxtpl import DocxTemplate
from jinja2 import Environment, StrictUndefined
ROOT=Path(__file__).resolve().parents[1]
class Person:
 def __init__(self,name):
  self.name=name;self.relationship='Friend';self.phone_number='612-555-0100';self.birthdate='January 2, 1970'
  self.address=SimpleNamespace(on_one_line=lambda:'123 Example Street, St. Paul, MN 55101',block=lambda:'123 Example Street\nSt. Paul, MN 55101')
 def __str__(self):return self.name
class People(list):
 def __str__(self):return ' and '.join(map(str,self))
PREFERENCES=['health_care_goals','health_care_fears','spiritual_beliefs','beliefs_about_quality_of_life','thoughts_about_family','pregnancy_care_wishes','temporary_incapacity_wishes','dying_care_wishes','permanent_unconsciousness_wishes','dependent_care_wishes','pain_relief_wishes','preferred_doctor','preferred_care_location','preferred_dying_location','organ_donation_wishes','body_disposition_wishes','other_health_care_wishes']
def render(path,context):
 with TemporaryDirectory() as tmp:
  dest=Path(tmp)/'rendered.docx';doc=DocxTemplate(path)
  doc.render(context,jinja_env=Environment(undefined=StrictUndefined),autoescape=True);doc.save(dest)
  result=Document(dest)
  text='\n'.join(p.text for p in result.paragraphs)
  assert '{{' not in text and '{%' not in text
  return text
class HCDTemplates(unittest.TestCase):
 def test_choices_do_not_require_unused_people_or_answers(self):
  path=ROOT/'docassemble/HealthCareDirective2026/data/templates/health_care_directive_2026.docx'
  for agent,instructions,alternate in [(False,True,False),(True,False,False),(True,True,False),(True,True,True)]:
   with self.subTest(agent=agent,instructions=instructions,alternate=alternate):
    context={'users':People([Person('Jordan Example')]),'directive_choices':{'agent':agent,'instructions':instructions}}
    if agent:
     context.update(primary_agent=Person('Alex Primary'),appoint_alternate_agent=alternate,limits_on_powers='',comments_on_agents_powers='')
     if alternate:context['alternate_agent']=Person('Taylor Alternate')
    if instructions:context.update({v:('Keep me comfortable.' if v=='other_health_care_wishes' else '') for v in PREFERENCES})
    text=render(path,context)
    self.assertEqual('Alex Primary' in text,agent)
    self.assertEqual('Taylor Alternate' in text,alternate)
    self.assertEqual('Keep me comfortable.' in text,instructions)
    self.assertNotIn('My fears about my health care:',text)
    self.assertIn('Part III: Making The Document Legal',text)
 def test_all_preferences_appear_without_losing_text(self):
  path=ROOT/'docassemble/HealthCareDirective2026/data/templates/health_care_directive_2026.docx'
  context={'users':People([Person('Jordan Example')]),'directive_choices':{'agent':False,'instructions':True}}
  context.update({v:'Distinct answer '+v+' < & >' for v in PREFERENCES})
  text=render(path,context)
  for v in PREFERENCES:self.assertIn('Distinct answer '+v+' < & >',text)
if __name__=='__main__':unittest.main()
