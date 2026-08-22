# Repository quality self-check

This is a repository-quality checklist based on the OSC2026 guide. The active
submission context is the August MoonBit hackathon; this document only records
engineering evidence and does not change or duplicate the proposal document.

| Check | Evidence |
| --- | --- |
| Standard module layout | `moon.mod`, root `moon.pkg`, `cmd/main/moon.pkg`, and `benchmarks/moon.pkg` |
| Public documentation | README covers positioning, capabilities, quick start, CLI, architecture, benchmark, tests, CI, and license |
| License | MIT text is present in `LICENSE` and declared in `moon.mod` |
| Runnable validation | `moon check`, `moon test`, all-target and native commands are documented and run locally |
| Reproducible example | `moon run cmd/main` prints quote summaries |
| Reproducible benchmark | `moon run benchmarks` prints the checksum `items=3000 total=CNY 269930.00` |
| Development trace | Git history contains focused feature, test, docs, and CI commits |
| Default branch | GitHub remote reports `main`; local `main` tracks `origin/main` |
| Production source scale | Conservative measured total is 16,895 MoonBit lines; see `source-inventory.md` |
| CI | Three OS matrix, stable installer, all-target check/test, coverage, formatting, and interface diff |

The check intentionally reports observable repository facts only. It does not
make claims about external registry availability or GitHub Actions results
until those states are observed after pushing.
