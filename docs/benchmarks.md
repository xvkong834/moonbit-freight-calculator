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

The elapsed time is machine-dependent. Acceptance reports should record the
full command, host OS, CPU, MoonBit version, and the median of three runs.
