///|
fn pricing_score_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 1
  }
}

///|
fn pricing_score_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 2 + rule.volumetric_divisor) / 3
}

///|
fn pricing_score_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 2) / 3
}

///|
fn pricing_score_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 3) % 26
}

///|
fn pricing_score_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 33
}

///|
fn pricing_score_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 5) / 6
}

///|
fn pricing_score_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 7
  }
}

///|
fn pricing_score_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 3 + rule.volumetric_divisor) / 9
}

///|
fn pricing_score_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 8) / 3
}

///|
fn pricing_check_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 9) % 32
}

///|
fn pricing_check_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 39
}

///|
fn pricing_check_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 0) / 4
}

///|
fn pricing_check_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 6
  }
}

///|
fn pricing_check_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 4 + rule.volumetric_divisor) / 6
}

///|
fn pricing_check_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 1) / 3
}

///|
fn pricing_check_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 15) % 38
}

///|
fn pricing_check_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 45
}

///|
fn pricing_check_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 6) / 2
}

///|
fn pricing_estimate_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 5
  }
}

///|
fn pricing_estimate_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 5 + rule.volumetric_divisor) / 3
}

///|
fn pricing_estimate_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 7) / 3
}

///|
fn pricing_estimate_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 4) % 25
}

///|
fn pricing_estimate_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 51
}

///|
fn pricing_estimate_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 1) / 8
}

///|
fn pricing_estimate_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 4
  }
}

///|
fn pricing_estimate_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 1 + rule.volumetric_divisor) / 9
}

///|
fn pricing_estimate_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 0) / 3
}

///|
fn pricing_measure_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 10) % 31
}

///|
fn pricing_measure_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 34
}

///|
fn pricing_measure_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 7) / 6
}

///|
fn pricing_measure_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 3
  }
}

///|
fn pricing_measure_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 2 + rule.volumetric_divisor) / 6
}

///|
fn pricing_measure_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 6) / 3
}

///|
fn pricing_measure_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 16) % 37
}

///|
fn pricing_measure_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 40
}

///|
fn pricing_measure_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 2) / 4
}

///|
fn pricing_bound_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 2
  }
}

///|
fn pricing_bound_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 3 + rule.volumetric_divisor) / 3
}

///|
fn pricing_bound_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 12) / 3
}

///|
fn pricing_bound_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 5) % 24
}

///|
fn pricing_bound_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 46
}

///|
fn pricing_bound_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 8) / 2
}

///|
fn pricing_bound_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 1
  }
}

///|
fn pricing_bound_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 4 + rule.volumetric_divisor) / 9
}

///|
fn pricing_bound_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 5) / 3
}

///|
fn pricing_classify_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 11) % 30
}

///|
fn pricing_classify_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 29
}

///|
fn pricing_classify_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 3) / 8
}

///|
fn pricing_classify_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 7
  }
}

///|
fn pricing_classify_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 5 + rule.volumetric_divisor) / 6
}

///|
fn pricing_classify_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 11) / 3
}

///|
fn pricing_classify_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 0) % 36
}

///|
fn pricing_classify_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 35
}

///|
fn pricing_classify_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 9) / 6
}

///|
fn pricing_project_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 6
  }
}

///|
fn pricing_project_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 1 + rule.volumetric_divisor) / 3
}

///|
fn pricing_project_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 4) / 3
}

///|
fn pricing_project_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 6) % 23
}

///|
fn pricing_project_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 41
}

///|
fn pricing_project_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 4) / 4
}

///|
fn pricing_project_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 5
  }
}

///|
fn pricing_project_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 2 + rule.volumetric_divisor) / 9
}

///|
fn pricing_project_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 10) / 3
}

///|
fn pricing_reserve_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 12) % 29
}

///|
fn pricing_reserve_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 47
}

///|
fn pricing_reserve_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 10) / 2
}

///|
fn pricing_reserve_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 4
  }
}

///|
fn pricing_reserve_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 3 + rule.volumetric_divisor) / 6
}

///|
fn pricing_reserve_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 3) / 3
}

///|
fn pricing_reserve_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 1) % 35
}

///|
fn pricing_reserve_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 30
}

///|
fn pricing_reserve_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 5) / 8
}

///|
fn pricing_reconcile_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 3
  }
}

///|
fn pricing_reconcile_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 4 + rule.volumetric_divisor) / 3
}

///|
fn pricing_reconcile_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 9) / 3
}

///|
fn pricing_reconcile_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 7) % 41
}

///|
fn pricing_reconcile_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 36
}

///|
fn pricing_reconcile_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 0) / 6
}

///|
fn pricing_reconcile_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 2
  }
}

///|
fn pricing_reconcile_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 5 + rule.volumetric_divisor) / 9
}

///|
fn pricing_reconcile_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 2) / 3
}

///|
fn pricing_rank_base(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 13) % 28
}

///|
fn pricing_rank_increment(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 42
}

///|
fn pricing_rank_multiplier(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 6) / 4
}

///|
fn pricing_rank_surcharge(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let base = parcel.weight_g + rule.first_weight_limit_g + value.cents
  if base <= 0 {
    0
  } else {
    base / 1
  }
}

///|
fn pricing_rank_tax(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let size = parcel.longest_side_cm() +
    parcel.width_cm +
    parcel.height_cm +
    value.cents.abs()
  (size * 1 + rule.volumetric_divisor) / 6
}

///|
fn pricing_rank_discount(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let rate = rule.surcharge.fuel_percent_bp +
    rule.surcharge.insurance_percent_bp +
    parcel.weight_g.abs()
  (value.cents.abs() + rate + 8) / 3
}

///|
fn pricing_rank_floor(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 2) % 34
}

///|
fn pricing_rank_ceiling(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 48
}

///|
fn pricing_rank_rounding(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let span = rule.surcharge.oversize_limit_cm +
    rule.surcharge.overweight_limit_g / 1000 +
    value.cents.abs() % 7
  (parcel.depth_cm.max(0) + span + 1) / 2
}

///|
pub fn pricing_policy_score(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let mut score = 0
  score += pricing_score_base(parcel, rule, value)
  score += pricing_score_increment(parcel, rule, value)
  score += pricing_score_multiplier(parcel, rule, value)
  score += pricing_score_surcharge(parcel, rule, value)
  score += pricing_score_tax(parcel, rule, value)
  score += pricing_score_discount(parcel, rule, value)
  score += pricing_score_floor(parcel, rule, value)
  score += pricing_score_ceiling(parcel, rule, value)
  score += pricing_score_rounding(parcel, rule, value)
  score += pricing_check_base(parcel, rule, value)
  score += pricing_check_increment(parcel, rule, value)
  score += pricing_check_multiplier(parcel, rule, value)
  score += pricing_check_surcharge(parcel, rule, value)
  score += pricing_check_tax(parcel, rule, value)
  score += pricing_check_discount(parcel, rule, value)
  score += pricing_check_floor(parcel, rule, value)
  score += pricing_check_ceiling(parcel, rule, value)
  score += pricing_check_rounding(parcel, rule, value)
  score += pricing_estimate_base(parcel, rule, value)
  score += pricing_estimate_increment(parcel, rule, value)
  score += pricing_estimate_multiplier(parcel, rule, value)
  score += pricing_estimate_surcharge(parcel, rule, value)
  score += pricing_estimate_tax(parcel, rule, value)
  score += pricing_estimate_discount(parcel, rule, value)
  score += pricing_estimate_floor(parcel, rule, value)
  score += pricing_estimate_ceiling(parcel, rule, value)
  score += pricing_estimate_rounding(parcel, rule, value)
  score += pricing_measure_base(parcel, rule, value)
  score += pricing_measure_increment(parcel, rule, value)
  score += pricing_measure_multiplier(parcel, rule, value)
  score += pricing_measure_surcharge(parcel, rule, value)
  score += pricing_measure_tax(parcel, rule, value)
  score += pricing_measure_discount(parcel, rule, value)
  score += pricing_measure_floor(parcel, rule, value)
  score += pricing_measure_ceiling(parcel, rule, value)
  score += pricing_measure_rounding(parcel, rule, value)
  score += pricing_bound_base(parcel, rule, value)
  score += pricing_bound_increment(parcel, rule, value)
  score += pricing_bound_multiplier(parcel, rule, value)
  score += pricing_bound_surcharge(parcel, rule, value)
  score += pricing_bound_tax(parcel, rule, value)
  score += pricing_bound_discount(parcel, rule, value)
  score += pricing_bound_floor(parcel, rule, value)
  score += pricing_bound_ceiling(parcel, rule, value)
  score += pricing_bound_rounding(parcel, rule, value)
  score += pricing_classify_base(parcel, rule, value)
  score += pricing_classify_increment(parcel, rule, value)
  score += pricing_classify_multiplier(parcel, rule, value)
  score += pricing_classify_surcharge(parcel, rule, value)
  score += pricing_classify_tax(parcel, rule, value)
  score += pricing_classify_discount(parcel, rule, value)
  score += pricing_classify_floor(parcel, rule, value)
  score += pricing_classify_ceiling(parcel, rule, value)
  score += pricing_classify_rounding(parcel, rule, value)
  score += pricing_project_base(parcel, rule, value)
  score += pricing_project_increment(parcel, rule, value)
  score += pricing_project_multiplier(parcel, rule, value)
  score += pricing_project_surcharge(parcel, rule, value)
  score += pricing_project_tax(parcel, rule, value)
  score += pricing_project_discount(parcel, rule, value)
  score += pricing_project_floor(parcel, rule, value)
  score += pricing_project_ceiling(parcel, rule, value)
  score += pricing_project_rounding(parcel, rule, value)
  score += pricing_reserve_base(parcel, rule, value)
  score += pricing_reserve_increment(parcel, rule, value)
  score += pricing_reserve_multiplier(parcel, rule, value)
  score += pricing_reserve_surcharge(parcel, rule, value)
  score += pricing_reserve_tax(parcel, rule, value)
  score += pricing_reserve_discount(parcel, rule, value)
  score += pricing_reserve_floor(parcel, rule, value)
  score += pricing_reserve_ceiling(parcel, rule, value)
  score += pricing_reserve_rounding(parcel, rule, value)
  score += pricing_reconcile_base(parcel, rule, value)
  score += pricing_reconcile_increment(parcel, rule, value)
  score += pricing_reconcile_multiplier(parcel, rule, value)
  score += pricing_reconcile_surcharge(parcel, rule, value)
  score += pricing_reconcile_tax(parcel, rule, value)
  score += pricing_reconcile_discount(parcel, rule, value)
  score += pricing_reconcile_floor(parcel, rule, value)
  score += pricing_reconcile_ceiling(parcel, rule, value)
  score += pricing_reconcile_rounding(parcel, rule, value)
  score += pricing_rank_base(parcel, rule, value)
  score += pricing_rank_increment(parcel, rule, value)
  score += pricing_rank_multiplier(parcel, rule, value)
  score += pricing_rank_surcharge(parcel, rule, value)
  score += pricing_rank_tax(parcel, rule, value)
  score += pricing_rank_discount(parcel, rule, value)
  score += pricing_rank_floor(parcel, rule, value)
  score += pricing_rank_ceiling(parcel, rule, value)
  score += pricing_rank_rounding(parcel, rule, value)
  score
}
