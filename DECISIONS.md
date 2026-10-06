# Implementation decisions

## Working conventions — 2026-10-04

- **Prioritize implementation over estimating remaining agent time.** Quinten wants most human hours reserved for feedback and iteration. Keep unresolved choices visible, but make ordinary development decisions without repeatedly seeking confirmation.
- **Use focused commits.** Separate template repair, interview behavior, document content, and infrastructure where they can be reviewed and tested independently. The initial setup commit established the repositories, validator, and review baseline; subsequent commits should have narrower subjects.
- **Use the Assembly Line style guide as the default.** Favor sentence case, short active instructions, related fields grouped into small screens, conditional follow-ups, and useful offramps. Treat lint output as review evidence, not authority to change substantive legal language.
- **Preserve proven interfaces.** Keep unique PDF field names and their suffixes. Preserve legitimate radio groups and repeated appearances of the same field; repair only incorrect links or mappings.
- **Separate evidence levels.** Static checks, synthetic template renders, browser walkthroughs, and client content approval answer different questions. Do not call any one of them production acceptance.

## References consulted

- [Assembly Line style guide](https://assemblyline.suffolklitlab.org/docs/style_guide/): local `~/AssemblyLine-docs/docs/style_guide/`, including readability, formatting, field organization, input validation, and exit screens.
- `~/all_interviews/repos/docassemble-PetitionToChangeNameOfAdult/.../petition_to_change_name_of_adult.yml`: mandatory controller, explicit branching, review actions, and preview/download patterns. Existing legacy style in this reference is not copied wholesale.
- `~/all_interviews/repos/docassemble-CLAGuardianship/.../caregiver_authorization_affidavit.yml`: person collection and caregiver-related questions. Massachusetts legal rules are not carried over.
- `~/docassemble-ALDashboard`: field-name contract, deterministic DOCX run edits and syntax checks, and accessible field labels.

## Initial template decisions

Preserve wet signatures, initials, execution dates, and witness/notary attestations for completion when signing. Add automation labels for information gathered by the interview. The PDFs' original unfilled page rasters were compared before/after field edits; they matched. The Name Change child-2 surname needed its own field because the original erroneously shared child 3's value. The shared foreclosure owner field is intentional and retained.

## Consistent help links — 2026-10-04

Use the verified matching LawHelpMN resource, [Health Care Directives](https://www.lawhelpmn.org/self-help-library/fact-sheet/health-care-directives), in publishing metadata, the introduction, the download screen, and printable next steps. Keep direct court/statutory sources for form requirements. Name Change’s matching resource is a court-forms directory, not an Education for Justice fact sheet. No claim of LHI feature parity is made.

## Complete optional directive routes

Replace the undeclared legacy agent list with explicit primary/alternate individuals. Ask only the selected agent/instruction branches, expose all 17 preferences in small topic groups, and omit unanswered prompts in the DOCX. Require an instruction if no agent is selected. Reevaluate the mandatory controller on review edits so cached completion flags cannot bypass a new branch. Keep wet signatures and optional-power initials on paper. Replace unrelated court/appeal instructions with directive-specific next steps.

Validation so far: localhost browser walkthroughs reached downloads for instructions-only, primary-agent-only, and both with an alternate. Strict synthetic DOCX tests also cover combined/no-alternate and special characters in all 17 answers. The broader story-table suite and layout review are in progress.

## Testing approach

Use narrative ALKiln story tables plus assertions against downloaded PDF text. Include negative paths, recording-date/deadline boundaries, optional people, long text, and review edits. Save raw artifacts locally and commit only a sanitized execution summary. Keep synthetic unit/template checks in CI. Distinguish failures in test-tool compatibility from actual interview defects; document both, and never turn a failed expectation into a pass without explaining the change.

## Plain-language and question-style review — 2026-10-04

Reviewed screens against plain-language guidance and the Assembly Line "Writing good questions" guide. Agent detail screens now have accurate headings ("Tell us about…" instead of "How can someone contact…" over a relationship field). Optional fields are labeled "(optional)". The agent-powers screen no longer asks a yes/no question over two text boxes. The review screen now shows answers in interview order. The instruction-variable list is defined once and shared by the validation and the mandatory check. The download screen says plainly that the directive is not valid until it is signed with witnesses or a notary.

## Shared LawHelpMN branding — 2026-10-05

Reference the installed `docassemble.LawHelpMNBranding` package directly: `LawHelpMNBranding_custom.css` supplies the Bootstrap theme and `LawHelpMN2x_002_resized.png` supplies the full logo. Set the AssemblyLine organization title and homepage to LawHelpMN. The branding package must be installed on the server. No branding assets or CSS adapters are copied into the interviews.
