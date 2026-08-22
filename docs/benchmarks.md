# Benchmark evidence

The benchmark is a deterministic smoke benchmark for the production quote
engine, not a synthetic microbenchmark. It processes the checked-in three-item
manifest 1,000 times, for 3,000 quote operations, and prints a checksum so a
run cannot silently skip work.

## Reproduction

```text
moon --version
moon run benchmarks
```

Expected checksum:

```text
items=3000 total=CNY 269930.00
```

Validation record from 2026-08-22: Windows host, MoonBit `0.1.20260807` /
moonc `0.10.7`, wasm-gc target. Three command wall times were 588.49 ms,
151.44 ms, and 154.74 ms; median 154.74 ms. This is 3,000 quote operations,
approximately 19,387 operations per second. The first run includes process or
build warm-up, so the median is the reported comparison value. Re-run the
command on the target host before making performance claims.
