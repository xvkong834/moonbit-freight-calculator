# moonbit-freight-calculator

Typed, deterministic freight-rating primitives for MoonBit applications. The
library turns parcel dimensions, weight, route, tariff bands, and surcharges
into an auditable quote made of exact integer-cent charge lines.

## Core capabilities

- Actual-versus-dimensional weight using configurable divisors.
- First-weight and incremental-weight ladder pricing.
- Zone multipliers, remote-area fees, overweight and oversize surcharges.
- Fuel and declared-value insurance charges with minimum-charge protection.
- Exact `Money` arithmetic, configurable rounding, discount stacks, and tax
  basis calculation.
- Route selection, service metadata, manifest totals, and weight outlier
  analysis.
- Built-in domestic, regional, international, and returns weight-band catalogs.
- CLI demo and a deterministic benchmark with a checksum.

## Quick start

```bash
moon check --target all
moon test --target all
moon run cmd/main
```

```mbt check
///|
test {
  let rule = standard_rule()
  let parcel = parcel_dim(width_cm=42, height_cm=30, depth_cm=24, weight_g=2600)
  let result = quote(rule, parcel, "regional", Money::yuan(300))
  inspect(result.summary(), content="billable=5040g total=CNY 61.03 lines=5")
}
```

## CLI

The example CLI quotes the checked-in sample manifest:

```text
moon run cmd/main
```

It prints one manifest total followed by an auditable summary for each parcel.
The library itself is pure and can be embedded without the CLI package.

## Architecture

```text
types.mbt                 public domain types
money*.mbt                exact money and rounding operations
parcel*.mbt               dimensional weight and parcel profiling
rules.mbt / audit*.mbt    tariff construction and validation
engine.mbt                quote and manifest calculation
discounts.mbt / taxes.mbt adjustments and tax basis
routing.mbt               origin/destination lane resolution
catalog*.mbt              operational weight-band tables
manifest_analytics.mbt    manifest-level operational metrics
cmd/main                  runnable example
benchmarks                deterministic performance smoke benchmark
```

Public concrete types live in the root package. Files are organizational
units; package boundaries are defined by `moon.pkg`.

## Benchmark

Run the real quote engine over the checked-in manifest 1,000 times:

```bash
moon run benchmarks
```

The reproducible checksum is `items=3000 total=CNY 269930.00`. Wall-clock
measurements depend on the host, so record the OS, CPU, MoonBit version, and
median of three runs. See [docs/benchmarks.md](docs/benchmarks.md).

## Testing and CI

Local validation:

```bash
moon fmt --check
moon check --deny-warn --target all
moon info
moon test --deny-warn --target all
moon test --deny-warn --target native --enable-coverage
moon coverage report -f summary
```

GitHub Actions runs the same quality gates on Ubuntu, macOS, and Windows. It
installs the current stable MoonBit toolchain, checks all backends, verifies
formatting and generated interfaces, runs tests with coverage, and executes the
native test target.

## License

MIT. See [LICENSE](LICENSE).
