///|
test "empty manifest has zero-safe summary" {
  let report = summarize_manifest([])
  inspect(report.count, content="0")
  inspect(report.average_weight_g, content="0")
  inspect(report.is_empty(), content="true")
}

///|
test "invalid parcel normalization never produces negative dimensions" {
  let normalized = parcel_dim(
    width_cm=-1,
    height_cm=0,
    depth_cm=20,
    weight_g=-50,
  ).normalized()
  inspect(normalized.width_cm, content="0")
  inspect(normalized.height_cm, content="0")
  inspect(normalized.weight_g, content="0")
  inspect(normalized.is_valid(), content="false")
}

///|
test "discounts never make payable negative" {
  let result = apply_discounts(Money::yuan(5), [
    discount_rule(code="too-large", percent_bp=10000, cap=Money::yuan(100)),
  ])
  inspect(result.payable.cents, content="0")
}

///|
test "invalid discount and tax policies are rejected" {
  inspect(
    discount_rule(code="", percent_bp=10001, cap=Money::yuan(-1)).valid(),
    content="false",
  )
  inspect(
    tax_policy(rate_bp=-1, threshold=Money::yuan(-1)).valid(),
    content="false",
  )
}

///|
test "tax threshold is part of the taxable basis" {
  let result = calculate_tax(
    tax_policy(rate_bp=1000, threshold=Money::yuan(100)),
    Money::yuan(20),
    Money::zero(),
  )
  inspect(result.tax.cents, content="1000")
}

///|
test "routing selects the fastest duplicate lane" {
  let lanes = [
    lane(origin="CN", destination="AU", zone="slow", transit_days=9),
    lane(origin="CN", destination="AU", zone="fast", transit_days=4),
  ]
  inspect(select_fastest_lane(lanes, "CN", "AU").zone, content="fast")
  inspect(select_fastest_lane(lanes, "CN", "AU").key(), content="CN->AU:fast")
}

///|
test "catalog boundaries are inclusive and empty lookup is safe" {
  let catalog = domestic_rate_catalog()
  inspect(find_operational_rate(catalog, 0).code, content="CN-D-0001")
  inspect(find_operational_rate(catalog, 499).code, content="CN-D-0001")
  inspect(find_operational_rate(catalog, 500).code, content="CN-D-0002")
  inspect(find_operational_rate([], 100).code, content="empty")
}

///|
test "money helpers preserve sign semantics" {
  inspect(Money::from_cents(-10).abs().cents, content="10")
  inspect(Money::from_cents(-10).is_negative(), content="true")
  inspect(
    Money::from_cents(10).difference(Money::from_cents(40)).cents,
    content="30",
  )
  inspect(Money::from_cents(17).round_to(10, Ceiling).cents, content="20")
}

///|
test "parcel profile reports density without division by zero" {
  let profile = analyze_parcel(
    parcel_dim(width_cm=0, height_cm=0, depth_cm=0, weight_g=500),
  )
  inspect(profile.density_g_per_l, content="500000")
  inspect(
    parcel_dim(width_cm=0, height_cm=0, depth_cm=0, weight_g=500).dimensional_density(),
    content="0",
  )
}
