# MoonBit source inventory

The final inventory is deliberately split between executable production logic
and typed rate-catalog data. Catalog data is compiled and used by the package,
but it is not presented as algorithmic implementation.

| Class | Files | Lines |
| --- | ---: | ---: |
| Non-catalog production logic | 37 | 15,660 |
| Typed rate-catalog data | 5 | 16,067 |
| Non-test production total | 42 | 31,727 |
| Test sources | 6 | 397 |

## Reproduction on PowerShell

Run from the repository root:

```powershell
$all = Get-ChildItem -Recurse -File -Filter '*.mbt' |
  Where-Object { $_.FullName -notmatch '\\_build\\|\\_probe_project\\' }
$prod = $all | Where-Object { $_.Name -notmatch '_test\.mbt$' }
$catalog = $prod | Where-Object {
  $_.Name -match '(^catalogs\.mbt$|_rate_catalog\.mbt$)'
}
$logic = $prod | Where-Object {
  $_.Name -notmatch '(^catalogs\.mbt$|_rate_catalog\.mbt$)'
}
function Count-Lines($items) {
  $n = 0
  foreach ($item in $items) {
    $n += [System.IO.File]::ReadAllLines($item.FullName).Count
  }
  return $n
}
Count-Lines $logic
Count-Lines $catalog
```

The command excludes build artifacts, probe projects, and test files. It does
not exclude or hide any production `.mbt` file.
