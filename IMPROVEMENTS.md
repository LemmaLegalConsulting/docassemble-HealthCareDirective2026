# Health Care Directive: prioritized review

Updated 2026-10-04 after implementation and local testing. See [TEST_SCENARIOS.md](TEST_SCENARIOS.md), [DECISIONS.md](DECISIONS.md), and saved `validation/` reports. Automated passes do not establish legal acceptance or LHI parity.

## Implemented

Defined primary/alternate agents, added all 17 preference questions, implemented agent-only/instructions-only/combined routes, conditional output and reviews, blank-instruction validation, and directive-specific next steps. Matching LawHelpMN help is linked in metadata, introduction, downloads, and printable instructions. Template labels are inventoried.

## Remaining priorities

1. **P0 — Approve the legal content and supported audience.** Confirm adult eligibility, agent qualifications, optional powers/initials, and the witness/notary instructions with Amanda. The interview does not yet enforce an adult-age gate. Preserve the distinction between a printable draft and a signed directive.

2. **P0 — Compare to the legacy interview and current client form.** Obtain the LHI ZIP or a branching/output specification and client examples. Automated tests cannot establish parity with the unavailable LHI engine.

3. **P1 — Review long documents and accessible output.** Long wishes and accented names render in scenario tests. Review pagination, signature space, document headings/reading order, and screen-reader/mobile use with a human. Retained statutory/form headings account for informational style findings.

4. **P1 — Review wording with intended users.** Questions are split into small topic groups, and the chosen sections control output. Test whether users understand the optional agent powers and the difference between instructions and naming an agent.

5. **P2 — Package and publication cleanup.** Remove unused generated dependencies after a clean server-install check. Finalize publisher branding, translation needs, privacy/terms, and publishing metadata before making the interview public.
