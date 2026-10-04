# Narrative scenarios and acceptance coverage

All people and addresses are synthetic. Story tables describe the current implementation; passing them does not establish legal completeness or LHI parity. See `validation/` for actual execution results, not an assumed pass.

| Tag | Persona / scenario | Purpose and expectation | Destination |
| --- | --- | --- | --- |
| `instructions_only` | Maya gives instructions without appointing anyone | Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated. | `download health care directive` |
| `agent_only` | Devon appoints one agent and leaves optional instructions blank | Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated. | `download health care directive` |
| `combined` | Noor appoints an agent and alternate and writes care wishes | Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated. | `download health care directive` |
| `combined_no_alternate` | Casey combines instructions with one agent | Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated. | `download health care directive` |
| `long_unicode` | María writes long wishes with accented names and punctuation | Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated. | `download health care directive` |
| `blank_instructions` | Lee leaves all instructions blank without an agent | Do not produce a directive with neither an agent nor instructions. | `after death wishes` |

## Additional review

Inspect long-answer pagination, signatures, mobile/keyboard navigation, and PDF reading order. Compare output with source forms and client-approved examples. Test limitations that require manual extra sheets as limitations, not as automated completion.

- `remove_agent`: Noor removes the agent after reaching downloads. Edit existing answers and assert the changed document or help screen.

- `remove_alternate`: Noor removes only the alternate agent. Edit existing answers and assert the changed document or help screen.

## Testing gaps to preserve for client review

No live LHI parity comparison, production deployment, full screen-reader audit, or client legal-content acceptance is claimed. See IMPROVEMENTS.md for the ordered remaining work. Extra-sheet workflows must be reviewed as manual steps.
