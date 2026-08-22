///|
fn reconcile_score_expected(
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
fn reconcile_score_actual(
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
fn reconcile_score_missing(
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
fn reconcile_score_extra(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 3) % 26
}

///|
fn reconcile_score_tolerance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 33
}

///|
fn reconcile_score_variance(
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
fn reconcile_score_duplicate(
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
fn reconcile_score_sequence(
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
fn reconcile_score_match(
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
fn reconcile_check_expected(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 9) % 32
}

///|
fn reconcile_check_actual(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 39
}

///|
fn reconcile_check_missing(
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
fn reconcile_check_extra(
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
fn reconcile_check_tolerance(
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
fn reconcile_check_variance(
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
fn reconcile_check_duplicate(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 15) % 38
}

///|
fn reconcile_check_sequence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 45
}

///|
fn reconcile_check_match(
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
fn reconcile_estimate_expected(
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
fn reconcile_estimate_actual(
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
fn reconcile_estimate_missing(
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
fn reconcile_estimate_extra(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 4) % 25
}

///|
fn reconcile_estimate_tolerance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 51
}

///|
fn reconcile_estimate_variance(
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
fn reconcile_estimate_duplicate(
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
fn reconcile_estimate_sequence(
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
fn reconcile_estimate_match(
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
fn reconcile_measure_expected(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 10) % 31
}

///|
fn reconcile_measure_actual(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 34
}

///|
fn reconcile_measure_missing(
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
fn reconcile_measure_extra(
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
fn reconcile_measure_tolerance(
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
fn reconcile_measure_variance(
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
fn reconcile_measure_duplicate(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 16) % 37
}

///|
fn reconcile_measure_sequence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 40
}

///|
fn reconcile_measure_match(
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
fn reconcile_bound_expected(
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
fn reconcile_bound_actual(
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
fn reconcile_bound_missing(
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
fn reconcile_bound_extra(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 5) % 24
}

///|
fn reconcile_bound_tolerance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 46
}

///|
fn reconcile_bound_variance(
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
fn reconcile_bound_duplicate(
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
fn reconcile_bound_sequence(
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
fn reconcile_bound_match(
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
fn reconcile_classify_expected(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 11) % 30
}

///|
fn reconcile_classify_actual(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 29
}

///|
fn reconcile_classify_missing(
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
fn reconcile_classify_extra(
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
fn reconcile_classify_tolerance(
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
fn reconcile_classify_variance(
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
fn reconcile_classify_duplicate(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 0) % 36
}

///|
fn reconcile_classify_sequence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 35
}

///|
fn reconcile_classify_match(
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
fn reconcile_project_expected(
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
fn reconcile_project_actual(
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
fn reconcile_project_missing(
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
fn reconcile_project_extra(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 6) % 23
}

///|
fn reconcile_project_tolerance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 41
}

///|
fn reconcile_project_variance(
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
fn reconcile_project_duplicate(
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
fn reconcile_project_sequence(
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
fn reconcile_project_match(
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
fn reconcile_reserve_expected(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 12) % 29
}

///|
fn reconcile_reserve_actual(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 47
}

///|
fn reconcile_reserve_missing(
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
fn reconcile_reserve_extra(
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
fn reconcile_reserve_tolerance(
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
fn reconcile_reserve_variance(
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
fn reconcile_reserve_duplicate(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 1) % 35
}

///|
fn reconcile_reserve_sequence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 30
}

///|
fn reconcile_reserve_match(
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
fn reconcile_reconcile_expected(
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
fn reconcile_reconcile_actual(
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
fn reconcile_reconcile_missing(
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
fn reconcile_reconcile_extra(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 7) % 41
}

///|
fn reconcile_reconcile_tolerance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 36
}

///|
fn reconcile_reconcile_variance(
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
fn reconcile_reconcile_duplicate(
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
fn reconcile_reconcile_sequence(
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
fn reconcile_reconcile_match(
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
fn reconcile_rank_expected(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 13) % 28
}

///|
fn reconcile_rank_actual(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 42
}

///|
fn reconcile_rank_missing(
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
fn reconcile_rank_extra(
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
fn reconcile_rank_tolerance(
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
fn reconcile_rank_variance(
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
fn reconcile_rank_duplicate(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 2) % 34
}

///|
fn reconcile_rank_sequence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 48
}

///|
fn reconcile_rank_match(
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
pub fn reconcile_policy_score(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let mut score = 0
  score += reconcile_score_expected(parcel, rule, value)
  score += reconcile_score_actual(parcel, rule, value)
  score += reconcile_score_missing(parcel, rule, value)
  score += reconcile_score_extra(parcel, rule, value)
  score += reconcile_score_tolerance(parcel, rule, value)
  score += reconcile_score_variance(parcel, rule, value)
  score += reconcile_score_duplicate(parcel, rule, value)
  score += reconcile_score_sequence(parcel, rule, value)
  score += reconcile_score_match(parcel, rule, value)
  score += reconcile_check_expected(parcel, rule, value)
  score += reconcile_check_actual(parcel, rule, value)
  score += reconcile_check_missing(parcel, rule, value)
  score += reconcile_check_extra(parcel, rule, value)
  score += reconcile_check_tolerance(parcel, rule, value)
  score += reconcile_check_variance(parcel, rule, value)
  score += reconcile_check_duplicate(parcel, rule, value)
  score += reconcile_check_sequence(parcel, rule, value)
  score += reconcile_check_match(parcel, rule, value)
  score += reconcile_estimate_expected(parcel, rule, value)
  score += reconcile_estimate_actual(parcel, rule, value)
  score += reconcile_estimate_missing(parcel, rule, value)
  score += reconcile_estimate_extra(parcel, rule, value)
  score += reconcile_estimate_tolerance(parcel, rule, value)
  score += reconcile_estimate_variance(parcel, rule, value)
  score += reconcile_estimate_duplicate(parcel, rule, value)
  score += reconcile_estimate_sequence(parcel, rule, value)
  score += reconcile_estimate_match(parcel, rule, value)
  score += reconcile_measure_expected(parcel, rule, value)
  score += reconcile_measure_actual(parcel, rule, value)
  score += reconcile_measure_missing(parcel, rule, value)
  score += reconcile_measure_extra(parcel, rule, value)
  score += reconcile_measure_tolerance(parcel, rule, value)
  score += reconcile_measure_variance(parcel, rule, value)
  score += reconcile_measure_duplicate(parcel, rule, value)
  score += reconcile_measure_sequence(parcel, rule, value)
  score += reconcile_measure_match(parcel, rule, value)
  score += reconcile_bound_expected(parcel, rule, value)
  score += reconcile_bound_actual(parcel, rule, value)
  score += reconcile_bound_missing(parcel, rule, value)
  score += reconcile_bound_extra(parcel, rule, value)
  score += reconcile_bound_tolerance(parcel, rule, value)
  score += reconcile_bound_variance(parcel, rule, value)
  score += reconcile_bound_duplicate(parcel, rule, value)
  score += reconcile_bound_sequence(parcel, rule, value)
  score += reconcile_bound_match(parcel, rule, value)
  score += reconcile_classify_expected(parcel, rule, value)
  score += reconcile_classify_actual(parcel, rule, value)
  score += reconcile_classify_missing(parcel, rule, value)
  score += reconcile_classify_extra(parcel, rule, value)
  score += reconcile_classify_tolerance(parcel, rule, value)
  score += reconcile_classify_variance(parcel, rule, value)
  score += reconcile_classify_duplicate(parcel, rule, value)
  score += reconcile_classify_sequence(parcel, rule, value)
  score += reconcile_classify_match(parcel, rule, value)
  score += reconcile_project_expected(parcel, rule, value)
  score += reconcile_project_actual(parcel, rule, value)
  score += reconcile_project_missing(parcel, rule, value)
  score += reconcile_project_extra(parcel, rule, value)
  score += reconcile_project_tolerance(parcel, rule, value)
  score += reconcile_project_variance(parcel, rule, value)
  score += reconcile_project_duplicate(parcel, rule, value)
  score += reconcile_project_sequence(parcel, rule, value)
  score += reconcile_project_match(parcel, rule, value)
  score += reconcile_reserve_expected(parcel, rule, value)
  score += reconcile_reserve_actual(parcel, rule, value)
  score += reconcile_reserve_missing(parcel, rule, value)
  score += reconcile_reserve_extra(parcel, rule, value)
  score += reconcile_reserve_tolerance(parcel, rule, value)
  score += reconcile_reserve_variance(parcel, rule, value)
  score += reconcile_reserve_duplicate(parcel, rule, value)
  score += reconcile_reserve_sequence(parcel, rule, value)
  score += reconcile_reserve_match(parcel, rule, value)
  score += reconcile_reconcile_expected(parcel, rule, value)
  score += reconcile_reconcile_actual(parcel, rule, value)
  score += reconcile_reconcile_missing(parcel, rule, value)
  score += reconcile_reconcile_extra(parcel, rule, value)
  score += reconcile_reconcile_tolerance(parcel, rule, value)
  score += reconcile_reconcile_variance(parcel, rule, value)
  score += reconcile_reconcile_duplicate(parcel, rule, value)
  score += reconcile_reconcile_sequence(parcel, rule, value)
  score += reconcile_reconcile_match(parcel, rule, value)
  score += reconcile_rank_expected(parcel, rule, value)
  score += reconcile_rank_actual(parcel, rule, value)
  score += reconcile_rank_missing(parcel, rule, value)
  score += reconcile_rank_extra(parcel, rule, value)
  score += reconcile_rank_tolerance(parcel, rule, value)
  score += reconcile_rank_variance(parcel, rule, value)
  score += reconcile_rank_duplicate(parcel, rule, value)
  score += reconcile_rank_sequence(parcel, rule, value)
  score += reconcile_rank_match(parcel, rule, value)
  score
}
