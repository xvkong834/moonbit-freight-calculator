///|
fn operations_score_intake(
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
fn operations_score_sort(
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
fn operations_score_load(
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
fn operations_score_dispatch(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 3) % 26
}

///|
fn operations_score_delivery(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 33
}

///|
fn operations_score_return(
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
fn operations_score_scan(
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
fn operations_score_handoff(
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
fn operations_score_capacity(
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
fn operations_check_intake(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 9) % 32
}

///|
fn operations_check_sort(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 39
}

///|
fn operations_check_load(
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
fn operations_check_dispatch(
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
fn operations_check_delivery(
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
fn operations_check_return(
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
fn operations_check_scan(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 15) % 38
}

///|
fn operations_check_handoff(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 45
}

///|
fn operations_check_capacity(
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
fn operations_estimate_intake(
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
fn operations_estimate_sort(
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
fn operations_estimate_load(
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
fn operations_estimate_dispatch(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 4) % 25
}

///|
fn operations_estimate_delivery(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 51
}

///|
fn operations_estimate_return(
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
fn operations_estimate_scan(
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
fn operations_estimate_handoff(
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
fn operations_estimate_capacity(
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
fn operations_measure_intake(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 10) % 31
}

///|
fn operations_measure_sort(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 34
}

///|
fn operations_measure_load(
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
fn operations_measure_dispatch(
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
fn operations_measure_delivery(
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
fn operations_measure_return(
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
fn operations_measure_scan(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 16) % 37
}

///|
fn operations_measure_handoff(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 40
}

///|
fn operations_measure_capacity(
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
fn operations_bound_intake(
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
fn operations_bound_sort(
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
fn operations_bound_load(
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
fn operations_bound_dispatch(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 5) % 24
}

///|
fn operations_bound_delivery(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 46
}

///|
fn operations_bound_return(
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
fn operations_bound_scan(
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
fn operations_bound_handoff(
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
fn operations_bound_capacity(
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
fn operations_classify_intake(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 11) % 30
}

///|
fn operations_classify_sort(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 29
}

///|
fn operations_classify_load(
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
fn operations_classify_dispatch(
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
fn operations_classify_delivery(
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
fn operations_classify_return(
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
fn operations_classify_scan(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 0) % 36
}

///|
fn operations_classify_handoff(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 35
}

///|
fn operations_classify_capacity(
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
fn operations_project_intake(
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
fn operations_project_sort(
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
fn operations_project_load(
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
fn operations_project_dispatch(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 6) % 23
}

///|
fn operations_project_delivery(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 41
}

///|
fn operations_project_return(
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
fn operations_project_scan(
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
fn operations_project_handoff(
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
fn operations_project_capacity(
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
fn operations_reserve_intake(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 12) % 29
}

///|
fn operations_reserve_sort(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 47
}

///|
fn operations_reserve_load(
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
fn operations_reserve_dispatch(
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
fn operations_reserve_delivery(
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
fn operations_reserve_return(
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
fn operations_reserve_scan(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 1) % 35
}

///|
fn operations_reserve_handoff(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 30
}

///|
fn operations_reserve_capacity(
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
fn operations_reconcile_intake(
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
fn operations_reconcile_sort(
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
fn operations_reconcile_load(
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
fn operations_reconcile_dispatch(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 7) % 41
}

///|
fn operations_reconcile_delivery(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 36
}

///|
fn operations_reconcile_return(
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
fn operations_reconcile_scan(
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
fn operations_reconcile_handoff(
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
fn operations_reconcile_capacity(
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
fn operations_rank_intake(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 13) % 28
}

///|
fn operations_rank_sort(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 42
}

///|
fn operations_rank_load(
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
fn operations_rank_dispatch(
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
fn operations_rank_delivery(
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
fn operations_rank_return(
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
fn operations_rank_scan(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 2) % 34
}

///|
fn operations_rank_handoff(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 48
}

///|
fn operations_rank_capacity(
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
pub fn operations_policy_score(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let mut score = 0
  score += operations_score_intake(parcel, rule, value)
  score += operations_score_sort(parcel, rule, value)
  score += operations_score_load(parcel, rule, value)
  score += operations_score_dispatch(parcel, rule, value)
  score += operations_score_delivery(parcel, rule, value)
  score += operations_score_return(parcel, rule, value)
  score += operations_score_scan(parcel, rule, value)
  score += operations_score_handoff(parcel, rule, value)
  score += operations_score_capacity(parcel, rule, value)
  score += operations_check_intake(parcel, rule, value)
  score += operations_check_sort(parcel, rule, value)
  score += operations_check_load(parcel, rule, value)
  score += operations_check_dispatch(parcel, rule, value)
  score += operations_check_delivery(parcel, rule, value)
  score += operations_check_return(parcel, rule, value)
  score += operations_check_scan(parcel, rule, value)
  score += operations_check_handoff(parcel, rule, value)
  score += operations_check_capacity(parcel, rule, value)
  score += operations_estimate_intake(parcel, rule, value)
  score += operations_estimate_sort(parcel, rule, value)
  score += operations_estimate_load(parcel, rule, value)
  score += operations_estimate_dispatch(parcel, rule, value)
  score += operations_estimate_delivery(parcel, rule, value)
  score += operations_estimate_return(parcel, rule, value)
  score += operations_estimate_scan(parcel, rule, value)
  score += operations_estimate_handoff(parcel, rule, value)
  score += operations_estimate_capacity(parcel, rule, value)
  score += operations_measure_intake(parcel, rule, value)
  score += operations_measure_sort(parcel, rule, value)
  score += operations_measure_load(parcel, rule, value)
  score += operations_measure_dispatch(parcel, rule, value)
  score += operations_measure_delivery(parcel, rule, value)
  score += operations_measure_return(parcel, rule, value)
  score += operations_measure_scan(parcel, rule, value)
  score += operations_measure_handoff(parcel, rule, value)
  score += operations_measure_capacity(parcel, rule, value)
  score += operations_bound_intake(parcel, rule, value)
  score += operations_bound_sort(parcel, rule, value)
  score += operations_bound_load(parcel, rule, value)
  score += operations_bound_dispatch(parcel, rule, value)
  score += operations_bound_delivery(parcel, rule, value)
  score += operations_bound_return(parcel, rule, value)
  score += operations_bound_scan(parcel, rule, value)
  score += operations_bound_handoff(parcel, rule, value)
  score += operations_bound_capacity(parcel, rule, value)
  score += operations_classify_intake(parcel, rule, value)
  score += operations_classify_sort(parcel, rule, value)
  score += operations_classify_load(parcel, rule, value)
  score += operations_classify_dispatch(parcel, rule, value)
  score += operations_classify_delivery(parcel, rule, value)
  score += operations_classify_return(parcel, rule, value)
  score += operations_classify_scan(parcel, rule, value)
  score += operations_classify_handoff(parcel, rule, value)
  score += operations_classify_capacity(parcel, rule, value)
  score += operations_project_intake(parcel, rule, value)
  score += operations_project_sort(parcel, rule, value)
  score += operations_project_load(parcel, rule, value)
  score += operations_project_dispatch(parcel, rule, value)
  score += operations_project_delivery(parcel, rule, value)
  score += operations_project_return(parcel, rule, value)
  score += operations_project_scan(parcel, rule, value)
  score += operations_project_handoff(parcel, rule, value)
  score += operations_project_capacity(parcel, rule, value)
  score += operations_reserve_intake(parcel, rule, value)
  score += operations_reserve_sort(parcel, rule, value)
  score += operations_reserve_load(parcel, rule, value)
  score += operations_reserve_dispatch(parcel, rule, value)
  score += operations_reserve_delivery(parcel, rule, value)
  score += operations_reserve_return(parcel, rule, value)
  score += operations_reserve_scan(parcel, rule, value)
  score += operations_reserve_handoff(parcel, rule, value)
  score += operations_reserve_capacity(parcel, rule, value)
  score += operations_reconcile_intake(parcel, rule, value)
  score += operations_reconcile_sort(parcel, rule, value)
  score += operations_reconcile_load(parcel, rule, value)
  score += operations_reconcile_dispatch(parcel, rule, value)
  score += operations_reconcile_delivery(parcel, rule, value)
  score += operations_reconcile_return(parcel, rule, value)
  score += operations_reconcile_scan(parcel, rule, value)
  score += operations_reconcile_handoff(parcel, rule, value)
  score += operations_reconcile_capacity(parcel, rule, value)
  score += operations_rank_intake(parcel, rule, value)
  score += operations_rank_sort(parcel, rule, value)
  score += operations_rank_load(parcel, rule, value)
  score += operations_rank_dispatch(parcel, rule, value)
  score += operations_rank_delivery(parcel, rule, value)
  score += operations_rank_return(parcel, rule, value)
  score += operations_rank_scan(parcel, rule, value)
  score += operations_rank_handoff(parcel, rule, value)
  score += operations_rank_capacity(parcel, rule, value)
  score
}
