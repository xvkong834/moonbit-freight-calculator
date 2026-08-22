# Production Logic Expansion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Expand non-catalog production MoonBit logic from the measured 831-line baseline to at least 12,000 lines of tested, application-facing logistics functionality.

**Architecture:** Keep the four operational rate tables as data-only production inputs and add cohesive logic packages in the root package: tariff rule composition, configuration diagnostics, settlement, SLA calendars, routing, manifest reconciliation, customs, bulk processing, audit reporting, and CLI-oriented formatting. Every public surface will operate on typed domain values and be exercised by focused tests; no generated filler or duplicated catalog rows will count toward the logic target.

**Tech Stack:** MoonBit stable toolchain, root `moon.pkg`, integer-cent Money, pure deterministic functions, snapshot/black-box tests, all-target CI, and native benchmark execution.

---

### Task 1: Define production-domain contracts and red tests

**Files:**
- Create: `production_domain_types.mbt`, `production_logic_test.mbt`

- [ ] Define typed contracts for tariff constraints, configuration diagnostics, settlement invoices, SLA calendars, reconciliation results, customs declarations, bulk jobs, audit events, and report sections.
- [ ] Add failing tests for rule precedence, invalid configuration diagnostics, invoice settlement, business-day deadlines, manifest reconciliation, customs totals, bulk chunking, and audit trace ordering.
- [ ] Run the focused test file and confirm failures are due to missing production APIs.

### Task 2: Implement rule composition and configuration diagnostics

**Files:**
- Create: `tariff_composition.mbt`, `configuration_diagnostics.mbt`
- Test: `production_logic_test.mbt`

- [ ] Implement deterministic rule priority, weight/dimension predicates, rule composition, effective-date selection, conflict detection, and explainable decisions.
- [ ] Implement schema/version checks, required-field diagnostics, severity aggregation, validation summaries, and safe defaults.
- [ ] Keep parsing/validation separate from quote execution so callers can reject invalid tariffs before billing.

### Task 3: Implement settlement, tax, discount, and reconciliation logic

**Files:**
- Create: `settlement_engine.mbt`, `settlement_reconciliation.mbt`
- Test: `settlement_test.mbt`

- [ ] Implement invoice lines, payment allocation, balance states, credit/debit adjustments, tax grouping, discount application, rounding reconciliation, and deterministic invoice summaries.
- [ ] Implement quote-versus-invoice diffing with tolerances, missing/extra line detection, and reconciliation status.
- [ ] Cover zero, negative, maximum, duplicate, and out-of-order input cases.

### Task 4: Implement SLA calendars, routing, customs, and bulk operations

**Files:**
- Create: `sla_calendar.mbt`, `route_planner.mbt`, `customs_engine.mbt`, `bulk_pipeline.mbt`
- Test: `operations_test.mbt`

- [ ] Implement business-day calendars, cutoff handling, service windows, route selection, route feasibility, customs duty/insurance, batch chunking, retry classification, and idempotency keys.
- [ ] Keep all calculations deterministic and backend-independent.

### Task 5: Implement audit and reporting surfaces

**Files:**
- Create: `audit_trace.mbt`, `operational_reports.mbt`, `cli_workflows.mbt`
- Test: `reporting_test.mbt`

- [ ] Implement ordered audit events, quote explanations, manifest reports, exception summaries, textual/CSV-safe formatting, and CLI workflow state transitions.
- [ ] Ensure every report has stable ordering and an explicit empty-state representation.

### Task 6: Scale, verify, and document the honest count

**Files:**
- Modify: `README.md`, `README.mbt.md`, `docs/quality/source-inventory.md`, `CHANGELOG.md`

- [ ] Run `moon fmt`, `moon check --deny-warn --target all`, all-target/native tests, coverage, CLI, and benchmark.
- [ ] Count production logic with an explicit exclusion for the four catalog files and verify it is at least 12,000 lines.
- [ ] Report catalog data lines and non-catalog logic lines separately; never merge them into one misleading metric.
- [ ] Commit, push, republish Mooncakes with an incremented version, and wait for all GitHub CI jobs to succeed.
