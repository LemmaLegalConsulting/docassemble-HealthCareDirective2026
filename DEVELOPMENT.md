# Development setup

Working repo: https://github.com/LemmaLegalConsulting/docassemble-HealthCareDirective2026
Original (`upstream`): https://github.com/AmandaSauber/docassemble-HealthCareDirective2026
Branch: `setup/validation-and-review`. The local test installation is on `http://localhost`; no apps-dev or public deployment was performed.

## Static and template checks

```sh
uv venv .venv
uv pip install --python .venv/bin/python -r requirements-dev.txt
.venv/bin/dayamlchecker --style .
.venv/bin/python -m unittest discover -s tests -p 'test_*.py'
```

DAYamlChecker is pinned to source commit `5676a949ebca269325eb0d8bf0abad52eda4aa61` (source version 1.7.0). URL and accessibility checks stay enabled. Errors fail CI; warnings remain review work. GitHub Actions also runs template regression tests. Use `uv run --no-project --with-requirements requirements-dev.txt ...` if running tools without installing this interview's runtime dependencies.

## Run the interview locally

```sh
/home/quinten/venv/bin/dainstall --server localhost .
```

Open `http://localhost/interview?i=docassemble.HealthCareDirective2026:data/questions/health_care_directive_2026.yml&new_session=1`.
Installing a package may restart the server; finish installations before starting browser suites. Use only synthetic test data.

## ALKiln story tables

Fixtures: `docassemble/HealthCareDirective2026/data/sources/scenarios.feature`.
Narratives and expected behavior: [TEST_SCENARIOS.md](TEST_SCENARIOS.md).

```sh
# Requires a checkout of ALKiln with its npm dependencies and Chromium installed.
# Defaults to ~/ALKiln; override ALKILN_PATH if needed.
.venv/bin/python tests/run_alkiln.py .
# Optional second argument is a Cucumber tag expression.
```

The runner uses the `localhost` entry in `~/.docassemblecli`, without printing or storing its key in tracked files. Install the package first. It tests the installed package rather than uploading a Playground. Reports, screenshots, and synthetic downloads go to ignored `.alkiln-artifacts/`. It requires Node, Chromium/Puppeteer, PyYAML, and `pdftotext` (Poppler).

Tested ALKiln checkout: `d7e4f42aa8a828013a8a229067697decf1322e5f`. `tests/steps.cjs` contains PDF assertions and narrow compatibility fixes for current Docassemble: button containers are divs, checkbox state is read from the native input, and Resume may change the question without changing the URL. Read-only error queries retry briefly if navigation replaces the DOM; input actions and assertion failures are never ignored. It also stops promptly on AssemblyLine's custom error screen. These are test-harness changes, not suppressed application failures. Reassess them when upgrading ALKiln.

## Template audit and decisions

`validation/template-labels.json` records the current labels and control tags. `validation/template-verification.json` records strict synthetic rendering and PDF checks. The workspace scripts `audit_current_templates.py` and `verify_templates.py` refresh them. Early one-time migration scripts are historical and should not be rerun against the edited templates.

Keep wet signatures, initials, execution dates, and witness/notarial attestations manual. Record substantive choices and sources in [DECISIONS.md](DECISIONS.md); keep the remaining release decisions in [IMPROVEMENTS.md](IMPROVEMENTS.md).
