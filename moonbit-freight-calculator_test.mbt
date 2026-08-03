///|
test "money formatting and percentages" {
  inspect(Money::from_cents(1205).to_string(), content="CNY 12.05")
  inspect(Money::yuan(99).percent_bp(350).to_string(), content="CNY 3.47")
}

///|
test "volumetric weight chooses larger value" {
  let parcel = parcel_dim(width_cm=60, height_cm=40, depth_cm=30, weight_g=5000)
  inspect(volumetric_weight_g(parcel, 6000), content="12000")
  inspect(billable_weight_g(parcel, 6000), content="12000")
}

///|
test "local quote has base and fuel only" {
  let q = quote(
    standard_rule(),
    parcel_dim(width_cm=18, height_cm=12, depth_cm=8, weight_g=850),
    "local",
    Money::zero(),
  )
  inspect(q.summary(), content="billable=850g total=CNY 12.42 lines=2")
}

///|
test "remote oversize quote includes surcharges" {
  let q = quote(
    standard_rule(),
    parcel_dim(width_cm=130, height_cm=28, depth_cm=22, weight_g=6800),
    "remote",
    Money::yuan(1200),
  )
  inspect(
    q.summary(),
    content=(
      #|billable=13347g total=CNY 196.48 lines=7
    ),
  )
}

///|
test "manifest totals all parcel quotes" {
  inspect(
    quote_manifest(standard_rule(), sample_manifest()).summary(),
    content=(
      #|items=3 total=CNY 269.93
    ),
  )
}

///|
test "rule validation catches invalid tariff data" {
  let broken = billing_rule(
    volumetric_divisor=0,
    first_weight_limit_g=1000,
    first_weight_rate=Money::yuan(-1),
    additional_weight_unit_g=0,
    additional_weight_rate=Money::yuan(4),
    min_charge=Money::zero(),
    zones=[
      zone_rate(zone="bad", multiplier_bp=0, remote_fee=Money::from_cents(-1)),
    ],
    surcharge=standard_rule().surcharge,
  )
  debug_inspect(
    validate_rule(broken),
    content=(
      #|[
      #|  NonPositiveDivisor,
      #|  NonPositiveWeightStep,
      #|  NegativeFee("first_weight_rate"),
      #|  InvalidZoneMultiplier("bad"),
      #|  NegativeFee("remote_fee:bad"),
      #|]
    ),
  )
}
