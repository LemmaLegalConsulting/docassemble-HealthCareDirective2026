# Health Care Directive: prioritized improvements

Reviewed 2026-10-04. This is a static source/template review; no completed browser interview has been verified. Synthetic template rendering is recorded in `validation/template-verification.json`. Passing DAYamlChecker does not establish production readiness.

## P0 — complete before a pilot release

1. **Define and gather the health care agents consistently.** `data/questions/health_care_directive_2026.yml`, `objects`, interview order, and “Health Care Agent Information”: `agent` is used but not declared locally or in the inspected AssemblyLine baseline. `health_care_agent` is a separate free-text name, while the DOCX uses both that value and `agent`. Consolidate the data model and test the primary and alternate names/addresses/phones in output.
2. **Support the document's optional sections.** The interview unconditionally accesses `agent[0]` and `agent[1]`; the form describes an optional alternate and a Part II-only route. Agree the supported routes with Amanda and implement branching. Test no agent, primary only, and primary plus alternate without collecting unwanted people.
3. **Wire the labeled Part II fields into the interview.** The setup pass added 17 answer placeholders for beliefs, treatment preferences, end-of-life wishes, and other instructions in `data/templates/health_care_directive_2026.docx`, plus birthdate/address labels. The YAML still only gathers names, relationships, contacts, and limits/comments on powers. Add optional questions and agree which sections are automated versus completed by hand; the labels alone do not collect answers. See `validation/template-labels.json` for the exact variable contract. Completing these branches is a material part of the estimate. Preserve the conditional-section request in [TEMPLATE_REVIEW_NOTES.md](TEMPLATE_REVIEW_NOTES.md).
4. **Replace the next-steps document.** It tells the user to deliver a copy to another party or attorney, wait for a response, and refers to a judge granting an appeal. Obtain approved directive-specific signing, witnessing/notarization, sharing, and storage instructions; review the `requires_notarization` metadata alongside the approved signing options.

## P1 — functional and document QA

5. Unify `user_name`, `user`, and `users`; avoid asking a separate “name or title” that is inserted as the declarant's name. Check the redundant names at the start of the DOCX and ensure the download thank-you does not trigger unrelated person questions.
6. Make genuinely optional limits/comments optional; check long answers, blank sections, page breaks, signature/witness space, and document accessibility. Preserve the form's intended execution process; do not assume an electronic signature is appropriate.
7. Correct the Massachusetts jurisdiction, empty default state, truncated short title, generic topic, and premature `maturity: production` metadata. Confirm eligibility and publication metadata with the client.
8. Make review/edit paths and navigation agree with the chosen branch. The preview screen exists but is not requested by the main order; decide the intended preview experience.

## P2 — polish

9. Address the saved style/accessibility findings: alt text or decorative marking for the image, heading structure in instructions, title metadata, all-cap headings, and excessive empty paragraphs. Test keyboard/mobile use and generated PDF reading order.
10. Review dependencies and generated packaging metadata; remove unused generator/runtime dependencies only after an installation test.

## Acceptance scenarios for the next development phase

- Agreed Part I-only, Part II-only, and combined routes; no alternate versus alternate agent.
- Optional answers blank versus completed; long names/addresses/preferences; review edits persist in output.
- Download both documents and inspect every populated field and signing area.
- Client approves substantive content and next steps before publication.

Planning range: **10–14 hours**, assuming existing form reuse and one consolidated client review round. Major new content or workflows need a revised estimate.
