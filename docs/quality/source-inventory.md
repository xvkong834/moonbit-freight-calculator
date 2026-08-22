# Source inventory

This inventory uses a conservative, reproducible count. It counts physical
lines in tracked production `.mbt` files, excludes `_build`, `_probe_project`,
files ending in `_test.mbt`, and generated `pkg.generated.mbti` files. It does
not count README snippets, Markdown, YAML, or the proposal document.

As of 2026-08-22:

```text
root production MoonBit source: 16864 lines
CLI production MoonBit source: 11 lines
benchmark production MoonBit source: 20 lines
production MoonBit source total: 16895 lines
MoonBit test source: 229 lines
```

The 16,895-line production total is the measured repository state, not an
estimate. The four checked-in operational rate catalogs are executable,
typed data tables used by the public lookup API; they are included in the
production total and are called out separately in the architecture docs.

Re-run the count from the repository root with PowerShell:

```powershell
$files = Get-ChildItem -Recurse -File -Filter *.mbt |
  Where-Object { $_.FullName -notmatch '\\_build\\|\\_probe_project\\|_test\.mbt$' }
($files | Get-Content | Measure-Object -Line).Lines
```
