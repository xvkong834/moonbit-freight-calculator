# Reproducible benchmark

The benchmark invokes the real quote engine over the checked-in sample manifest
1,000 times. It is intentionally deterministic: there is no network, clock, or
random input in the workload.

Run it from the repository root:

```bash
moon run benchmarks
```

For wall-clock measurements, run the command three times with the same MoonBit
toolchain and record the median elapsed time. The output checksum must remain:

```text
items=3000 total=CNY 269930.00
```
