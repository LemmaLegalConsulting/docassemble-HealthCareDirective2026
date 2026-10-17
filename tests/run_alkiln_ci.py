"""Run every ALKiln feature with this repository's PDF and compatibility steps."""
from pathlib import Path
import json
import os
import subprocess
import sys

repo = Path(__file__).resolve().parents[1]
alkiln = Path(os.environ["ALKILN_PATH"]).resolve()
package = next((repo / "docassemble").glob("*/data/questions")).parents[1].name
sources = repo / "docassemble" / package / "data/sources"
artifacts = repo / ".alkiln-artifacts" / "ci"
artifacts.mkdir(parents=True, exist_ok=True)
# The bootstrap stores only paths and install mode, never server credentials.
helper = artifacts / "bootstrap.cjs"
helper.write_text(
    "const s=require(" + json.dumps(str(alkiln / "lib/utils/session_vars.js")) + ");"
    + "s.save_install_method('server');"
    + "s.save_repo_folder_name(" + json.dumps(package) + ");"
    + "s.save_artifacts_path_name(" + json.dumps(str(artifacts)) + ");"
    + "s.set_sources_paths([" + json.dumps(str(sources)) + "]);"
)
command = [
    "node", str(alkiln / "node_modules/@cucumber/cucumber/bin/cucumber.js"),
    "--require", str(helper),
    "--require", str(alkiln / "lib/index.js"),
    "--require", str(repo / "tests/steps.cjs"),
    "--exit",
    "--format", "progress",
    "--format", "json:" + str(artifacts / "cucumber.json"),
    "--format", "summary:" + str(artifacts / "summary.txt"),
]
tags = os.environ.get("ALKILN_TAG_EXPRESSION", "").strip()
if tags:
    command += ["--tags", tags]
command += [str(sources / "*.feature")]
sys.exit(subprocess.run(command, cwd=artifacts, env=os.environ.copy()).returncode)
