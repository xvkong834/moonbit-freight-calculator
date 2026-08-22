///|
test "every built-in rate catalog is valid and searchable" {
  let catalogs = [
    domestic_rate_catalog(),
    regional_rate_catalog(),
    international_rate_catalog(),
    returns_rate_catalog(),
  ]
  for catalog in catalogs {
    assert_eq(catalog.length(), 500)
    for rate in catalog {
      assert_true(rate.is_valid())
      assert_true(rate.contains(rate.minimum_g))
      assert_eq(rate.span(), 499)
    }
  }
}

///|
test "public adjustment helpers remain composable" {
  let discounts = combine_discount_rules([
    [discount_rule(code="member", percent_bp=500, cap=Money::yuan(20))],
    [discount_rule(code="volume", percent_bp=1000, cap=Money::yuan(100))],
  ])
  let result = apply_discounts(Money::yuan(100), discounts)
  assert_eq(result.effective_rate_bp(), 1500)
  assert_eq(
    calculate_tax(
      tax_policy(rate_bp=600, threshold=Money::zero()),
      result.payable,
      Money::zero(),
    ).net_of_tax().cents,
    result.payable.cents,
  )
}
