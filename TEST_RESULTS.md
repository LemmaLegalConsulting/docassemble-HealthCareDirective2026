# Verified local test baseline

On October 4, 2026, all **8 scenarios and 63 story steps passed** against the installed localhost package. See [the sanitized execution report](validation/alkiln-results.json) for names, source revision, hashes, and artifact location. Fixtures include generated-PDF assertions and review edits. Browser screenshots and synthetic downloads remain locally in the ignored artifact folder.

DAYamlChecker default and style checks report **zero errors**. Remaining warnings and informational findings are preserved in `validation/dayamlchecker*.txt`. Template regression tests passed; the current template inventory and rendered-output checks are saved in `validation/template-labels.json` and `validation/template-verification.json`.

Earlier exploratory failures are retained locally. They identified application defects (including Name Change county gathering and the extra-spouse loop) and test-harness incompatibilities with the installed Docassemble version. The checked-in harness documents its checkbox, button, navigation, and read-only DOM-query compatibility fixes. No failed assertion is converted to a pass. A foreclosure navigation race was reproduced and rerun before the final complete suite passed.

The Name Change full run predates the final read-only DOM-query retry; its story fixtures and application were unchanged. Health Care Directive and foreclosure full runs include that retry. The retry only handles a browser execution context disappearing during navigation.

This is a development baseline, not client legal acceptance, live LHI parity, complete accessibility testing, or production deployment. Prioritized remaining work is in [IMPROVEMENTS.md](IMPROVEMENTS.md).
