# moonbit-freight-calculator

MoonBit freight calculator for parcel logistics. It models common carrier billing rules as testable pure functions: actual weight vs dimensional weight, first-weight and incremental-weight ladder pricing, zone multipliers, remote area fees, overweight and oversize surcharges, fuel surcharge, insurance, minimum charge, and batch manifest totals.

## Why

Before choosing this topic, the mooncakes.io ecosystem was checked with freight, tariff, pricing, and logistics keywords. No mature MoonBit freight billing engine with highly overlapping scope was found. Existing packages cover useful foundations such as JSONPath, regexp, and decimal arithmetic; this project focuses on reusable logistics business rules.

## Quick Start

```bash
moon check
moon test
moon run cmd/main
```

```mbt check
///|
test {
  let rule = standard_rule()
  let parcel = parcel_dim(width_cm=42, height_cm=30, depth_cm=24, weight_g=2600)
  let result = quote(rule, parcel, "regional", Money::yuan(300))
  inspect(
    result.summary(),
    content=(
      #|billable=5040g total=CNY 61.03 lines=5
    ),
  )
}
```

## Features

- Integer-cent `Money` model, avoiding floating-point rounding drift.
- Configurable `BillingRule` with zone table and surcharge policy.
- Quote breakdown as typed `ChargeLine` values for audit and invoices.
- Batch manifest quotation with total aggregation.
- `validate_rule` for tariff sanity checks before runtime use.
- CLI demo under `cmd/main`.

## Project Structure

```text
.
+-- types.mbt       # public domain model
+-- money.mbt       # exact cent arithmetic
+-- parcel.mbt      # dimensional weight helpers
+-- rules.mbt       # tariff builders and zone lookup
+-- engine.mbt      # quote and manifest calculation
+-- audit.mbt       # rule validation
+-- format.mbt      # summaries and line descriptions
+-- fixtures.mbt    # sample logistics manifest
+-- cmd/main        # runnable CLI demo
+-- .github/workflows/test.yml
```

## Validation

CI and local checks run:

```bash
moon fmt --check
moon check --deny-warn
moon info
moon test --deny-warn
moon test --deny-warn --target native
```

## Roadmap

- JSON import/export for tariff tables.
- More rule combinators for discounts, SLA windows, and customer tiers.
- CSV manifest parser for operations teams.
- Mooncakes package publication after hackathon review.

## License

MIT
