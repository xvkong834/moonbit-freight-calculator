///|
test "money rounding uses half up cents" {
  inspect(Money::from_cents(105).round_to(10, HalfUp).cents, content="110")
  inspect(Money::from_cents(104).round_to(10, HalfUp).cents, content="100")
}

///|
test "parcel normalization orders dimensions and adds handling metrics" {
  let parcel = parcel_dim(width_cm=10, height_cm=30, depth_cm=20, weight_g=2500)
  let profile = analyze_parcel(parcel)
  inspect(profile.longest_side_cm, content="30")
  inspect(profile.shortest_side_cm, content="10")
  inspect(profile.girth_cm, content="60")
  inspect(profile.footprint_cm2, content="200")
}

///|
test "discount stack respects caps and floor" {
  let rules = [
    discount_rule(code="member", percent_bp=500, cap=Money::yuan(20)),
    discount_rule(code="volume", percent_bp=1000, cap=Money::yuan(100)),
  ]
  let result = apply_discounts(Money::yuan(100), rules)
  inspect(result.discount.cents, content="1500")
  inspect(result.payable.cents, content="8500")
}

///|
test "tax calculation separates taxable and exempt lines" {
  let taxable = Money::yuan(80)
  let exempt = Money::yuan(20)
  let result = calculate_tax(
    tax_policy(rate_bp=600, threshold=Money::yuan(0)),
    taxable,
    exempt,
  )
  inspect(result.tax.cents, content="480")
  inspect(result.gross.cents, content="10480")
}

///|
test "lane routing falls back to default service" {
  let lanes = [
    lane(
      origin="CN",
      destination="JP",
      zone="international-east",
      transit_days=4,
    ),
  ]
  let route = resolve_lane(lanes, "CN", "JP")
  inspect(route.zone, content="international-east")
  inspect(resolve_lane(lanes, "CN", "US").zone, content="default")
}

///|
test "manifest analytics detects weight outliers" {
  let values = [
    parcel_dim(width_cm=10, height_cm=10, depth_cm=10, weight_g=1000),
    parcel_dim(width_cm=10, height_cm=10, depth_cm=10, weight_g=1100),
    parcel_dim(width_cm=10, height_cm=10, depth_cm=10, weight_g=9000),
  ]
  let report = summarize_manifest(values)
  inspect(report.count, content="3")
  inspect(report.max_weight_g, content="9000")
  inspect(report.outlier_count, content="1")
}
