# Freight Hackathon Acceptance Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn the MoonBit freight calculator into a production-oriented, testable logistics pricing library with more than 12,000 measured production MoonBit source lines, reproducible benchmarks, complete CI, and a publishable package.

**Architecture:** Preserve the existing root facade and split new behavior into cohesive domain files: money/rounding, parcel normalization, tariff validation, discounts/tax, service-level rules, route and region catalogs, manifest analytics, and serialization-friendly reporting. Keep public concrete types in the root package and keep fixtures/benchmarks separate from production APIs.

**Tech Stack:** MoonBit stable toolchain, standard `moon.mod`/`moon.pkg` layout, GitHub Actions on Linux/macOS/Windows, native and wasm-gc checks, MoonBit tests and coverage, GitHub CLI, and Mooncakes publishing through `moon publish`.

---

### Task 1: Establish the baseline and acceptance inventory

**Files:**
- Read: `申报书.md`, existing `.mbt`, `.github/workflows/test.yml`, `moon.mod`, `LICENSE`, `README.mbt.md`
- Create: `docs/quality/source-inventory.md`

- [ ] Record current production/test line counts with an explicit command that excludes `_build`, generated interfaces, and tests.
- [ ] Record current package name, remote default branch, toolchain version, and existing validation failures.
- [ ] Do not modify `申报书.md`.

### Task 2: Add tested production pricing domains

**Files:**
- Create: `money_rounding.mbt`, `parcel_normalization.mbt`, `tariff_validation.mbt`, `discounts.mbt`, `taxes.mbt`, `service_levels.mbt`, `routing.mbt`, `manifest_analytics.mbt`, `reporting.mbt`
- Modify: `types.mbt`, `rules.mbt`, `audit.mbt`, `engine.mbt`
- Test: `acceptance_edge_test.mbt`, `pricing_domains_test.mbt`

- [ ] First add tests for negative/zero values, rounding ties, dimension permutations, empty manifests, unknown zones, discount caps, tax-inclusive totals, and SLA boundary timestamps.
- [ ] Run the focused tests and verify they fail because the new API is absent.
- [ ] Implement the smallest tested APIs using integer cents, explicit result enums, overflow-safe checks, and deterministic ordering.
- [ ] Add realistic capabilities: stacked discounts, tax basis, lane routing, service-level windows, package normalization, manifest aggregation, outlier detection, and audit reports.
- [ ] Run targeted tests, then `moon fmt`, `moon check`, and `moon info`.

### Task 3: Expand reusable logistics catalogs and operational helpers

**Files:**
- Create: focused `catalog_*.mbt` and `operations_*.mbt` files under the root package
- Test: corresponding `*_test.mbt` files

- [ ] Add data-driven domestic/international zone descriptors, carrier service profiles, surcharge policies, delivery calendars, packaging presets, and customs/declared-value helpers.
- [ ] Keep each file cohesive; avoid filler declarations and count only compilable production `.mbt` lines in the inventory.
- [ ] Add table-driven boundary tests for every catalog family and public helper.
- [ ] Verify the production count exceeds 12,000 lines using the inventory command, reporting the exact count.

### Task 4: Add reproducible benchmarks and evidence

**Files:**
- Create: `benchmarks/README.md`, `benchmarks/benchmark.mbt`, `benchmarks/data/manifest-1000.mbt`
- Create: `docs/benchmarks.md`

- [ ] Benchmark the real sample manifest and a deterministic 1,000-item manifest using the actual quote engine.
- [ ] Capture command, toolchain version, target, item count, elapsed wall time, and throughput from fresh local runs.
- [ ] Document that benchmark values are environment-specific and provide a rerun command.

### Task 5: Mature documentation and CI

**Files:**
- Modify: `README.mbt.md`, `.github/workflows/test.yml`, `moon.mod`
- Create: `.github/workflows/benchmark.yml`, `CHANGELOG.md`

- [ ] Restructure README into positioning, capabilities, quick start, CLI, architecture, benchmarks, tests, CI, and MIT license.
- [ ] Remove internal application/acceptance/contributor wording from README.
- [ ] Follow the MoonBit community template pattern: stable installer, `moon version --all`, `moon update`, all-target check/test, format and generated-interface cleanliness, coverage, and least-privilege checkout.
- [ ] Pin or document the stable toolchain strategy without claiming a version that was not measured.

### Task 6: Verify, self-check, publish, and push

**Files:**
- Modify: generated `pkg.generated.mbti` files as produced by `moon info`
- Create if needed: `docs/quality/osc2026-self-check.md`

- [ ] Run full format, check, info diff, tests, native tests, all-target checks, coverage, CLI, and benchmark commands.
- [ ] Review repository structure, README, license, history, remote/default branch, and exact MoonBit production line count against `osc2026-guide`.
- [ ] Commit changes with focused messages, verify GitHub authentication, push `main`, and confirm the remote commit.
- [ ] Publish to Mooncakes using the authenticated MoonBit CLI only after package metadata and full validation pass.
- [ ] Report exact evidence, including any external CI or registry state that cannot be observed locally.
