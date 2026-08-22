///|
test "operational catalogs provide deterministic rate lookup" {
  let first = domestic_rate_catalog()[0]
  inspect(first.code, content="CN-D-0001")
  inspect(first.minimum_g, content="0")
  inspect(
    find_operational_rate(domestic_rate_catalog(), 1200).code,
    content="CN-D-0003",
  )
}
