# Development setup

Local checkout: `/home/quinten/minnesota/docassemble-HealthCareDirective2026`.
Working repository: https://github.com/LemmaLegalConsulting/docassemble-HealthCareDirective2026
Original repository (`upstream`): https://github.com/AmandaSauber/docassemble-HealthCareDirective2026
Setup branch: `setup/validation-and-review`.

## Validate

```sh
uv venv .venv
uv pip install --python .venv/bin/python -r requirements-dev.txt
.venv/bin/dayamlchecker --style .
```

The checker is pinned to source version 1.7.0 at `5676a949ebca269325eb0d8bf0abad52eda4aa61`. This includes DOCX comments/tracked-change checks absent from the globally installed 1.4.0 checker. URL and accessibility checks stay enabled; errors fail the check, warnings remain review tasks. `--no-url-check` is useful for offline iteration only. GitHub Actions runs the full command on pushes and pull requests.

Saved baseline results are in `validation/`. The checker cannot verify legal correctness, all undefined runtime variables, rendered output, or complete interview paths. See [IMPROVEMENTS.md](IMPROVEMENTS.md) for those tasks.

## Run on Docassemble

Install this repository's `setup/validation-and-review` branch through a development server's package administration screen, including its declared dependencies. Then open:

```text
https://apps-dev.suffolklitlab.org/interview?i=docassemble.HealthCareDirective2026:data/questions/health_care_directive_2026.yml
```

This launch URL works after installation; this setup task has not installed or deployed the branch. Use synthetic test information. Do not publish until the P0 items and client content review are complete.

## Continue development

```sh
git fetch upstream
git switch setup/validation-and-review
git status
```

Keep `upstream` for Amanda's source history and `origin` for Lemma's fork. Review any newer upstream changes before merging. The checked-out setup branch contains validation fixes and review documentation, not the full substantive completion work.

## Template labels

`validation/template-labels.json` inventories every DOCX expression and every logical PDF field, its accessible label, and its YAML mapping. `validation/template-verification.json` records independent synthetic rendering checks. Those checks do not exercise a running interview.

The workspace's `scripts/label_templates.py` uses ALDashboard's run editor and syntax validator and preserves existing PDF field names except the corrected child-2 field. Intentional repeated appearances of the same owner and valid radio-button groups remain linked. Wet signatures, initials, execution dates, and witness/notary completion remain manual; the inventory records that boundary. `scripts/verify_templates.py` checks the templates using synthetic data. New HCD labels require corresponding interview questions before release. Next-steps boilerplate still needs client-approved content.
