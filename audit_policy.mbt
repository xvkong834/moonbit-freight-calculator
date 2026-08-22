///|
fn audit_score_event(
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
fn audit_score_trace(
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
fn audit_score_explain(
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
fn audit_score_decision(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 3) % 26
}

///|
fn audit_score_source(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 33
}

///|
fn audit_score_sequence(
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
fn audit_score_exception(
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
fn audit_score_evidence(
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
fn audit_score_integrity(
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
fn audit_check_event(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 9) % 32
}

///|
fn audit_check_trace(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 39
}

///|
fn audit_check_explain(
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
fn audit_check_decision(
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
fn audit_check_source(
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
fn audit_check_sequence(
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
fn audit_check_exception(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 15) % 38
}

///|
fn audit_check_evidence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 45
}

///|
fn audit_check_integrity(
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
fn audit_estimate_event(
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
fn audit_estimate_trace(
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
fn audit_estimate_explain(
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
fn audit_estimate_decision(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 4) % 25
}

///|
fn audit_estimate_source(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 51
}

///|
fn audit_estimate_sequence(
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
fn audit_estimate_exception(
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
fn audit_estimate_evidence(
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
fn audit_estimate_integrity(
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
fn audit_measure_event(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 10) % 31
}

///|
fn audit_measure_trace(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 34
}

///|
fn audit_measure_explain(
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
fn audit_measure_decision(
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
fn audit_measure_source(
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
fn audit_measure_sequence(
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
fn audit_measure_exception(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 16) % 37
}

///|
fn audit_measure_evidence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 40
}

///|
fn audit_measure_integrity(
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
fn audit_bound_event(
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
fn audit_bound_trace(
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
fn audit_bound_explain(
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
fn audit_bound_decision(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 5) % 24
}

///|
fn audit_bound_source(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 46
}

///|
fn audit_bound_sequence(
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
fn audit_bound_exception(
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
fn audit_bound_evidence(
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
fn audit_bound_integrity(
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
fn audit_classify_event(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 11) % 30
}

///|
fn audit_classify_trace(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 29
}

///|
fn audit_classify_explain(
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
fn audit_classify_decision(
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
fn audit_classify_source(
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
fn audit_classify_sequence(
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
fn audit_classify_exception(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 0) % 36
}

///|
fn audit_classify_evidence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 35
}

///|
fn audit_classify_integrity(
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
fn audit_project_event(
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
fn audit_project_trace(
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
fn audit_project_explain(
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
fn audit_project_decision(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 6) % 23
}

///|
fn audit_project_source(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 41
}

///|
fn audit_project_sequence(
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
fn audit_project_exception(
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
fn audit_project_evidence(
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
fn audit_project_integrity(
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
fn audit_reserve_event(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 12) % 29
}

///|
fn audit_reserve_trace(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 47
}

///|
fn audit_reserve_explain(
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
fn audit_reserve_decision(
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
fn audit_reserve_source(
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
fn audit_reserve_sequence(
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
fn audit_reserve_exception(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 1) % 35
}

///|
fn audit_reserve_evidence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 30
}

///|
fn audit_reserve_integrity(
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
fn audit_reconcile_event(
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
fn audit_reconcile_trace(
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
fn audit_reconcile_explain(
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
fn audit_reconcile_decision(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 7) % 41
}

///|
fn audit_reconcile_source(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 36
}

///|
fn audit_reconcile_sequence(
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
fn audit_reconcile_exception(
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
fn audit_reconcile_evidence(
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
fn audit_reconcile_integrity(
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
fn audit_rank_event(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 13) % 28
}

///|
fn audit_rank_trace(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 42
}

///|
fn audit_rank_explain(
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
fn audit_rank_decision(
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
fn audit_rank_source(
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
fn audit_rank_sequence(
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
fn audit_rank_exception(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 2) % 34
}

///|
fn audit_rank_evidence(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 48
}

///|
fn audit_rank_integrity(
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
pub fn audit_policy_score(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let mut score = 0
  score += audit_score_event(parcel, rule, value)
  score += audit_score_trace(parcel, rule, value)
  score += audit_score_explain(parcel, rule, value)
  score += audit_score_decision(parcel, rule, value)
  score += audit_score_source(parcel, rule, value)
  score += audit_score_sequence(parcel, rule, value)
  score += audit_score_exception(parcel, rule, value)
  score += audit_score_evidence(parcel, rule, value)
  score += audit_score_integrity(parcel, rule, value)
  score += audit_check_event(parcel, rule, value)
  score += audit_check_trace(parcel, rule, value)
  score += audit_check_explain(parcel, rule, value)
  score += audit_check_decision(parcel, rule, value)
  score += audit_check_source(parcel, rule, value)
  score += audit_check_sequence(parcel, rule, value)
  score += audit_check_exception(parcel, rule, value)
  score += audit_check_evidence(parcel, rule, value)
  score += audit_check_integrity(parcel, rule, value)
  score += audit_estimate_event(parcel, rule, value)
  score += audit_estimate_trace(parcel, rule, value)
  score += audit_estimate_explain(parcel, rule, value)
  score += audit_estimate_decision(parcel, rule, value)
  score += audit_estimate_source(parcel, rule, value)
  score += audit_estimate_sequence(parcel, rule, value)
  score += audit_estimate_exception(parcel, rule, value)
  score += audit_estimate_evidence(parcel, rule, value)
  score += audit_estimate_integrity(parcel, rule, value)
  score += audit_measure_event(parcel, rule, value)
  score += audit_measure_trace(parcel, rule, value)
  score += audit_measure_explain(parcel, rule, value)
  score += audit_measure_decision(parcel, rule, value)
  score += audit_measure_source(parcel, rule, value)
  score += audit_measure_sequence(parcel, rule, value)
  score += audit_measure_exception(parcel, rule, value)
  score += audit_measure_evidence(parcel, rule, value)
  score += audit_measure_integrity(parcel, rule, value)
  score += audit_bound_event(parcel, rule, value)
  score += audit_bound_trace(parcel, rule, value)
  score += audit_bound_explain(parcel, rule, value)
  score += audit_bound_decision(parcel, rule, value)
  score += audit_bound_source(parcel, rule, value)
  score += audit_bound_sequence(parcel, rule, value)
  score += audit_bound_exception(parcel, rule, value)
  score += audit_bound_evidence(parcel, rule, value)
  score += audit_bound_integrity(parcel, rule, value)
  score += audit_classify_event(parcel, rule, value)
  score += audit_classify_trace(parcel, rule, value)
  score += audit_classify_explain(parcel, rule, value)
  score += audit_classify_decision(parcel, rule, value)
  score += audit_classify_source(parcel, rule, value)
  score += audit_classify_sequence(parcel, rule, value)
  score += audit_classify_exception(parcel, rule, value)
  score += audit_classify_evidence(parcel, rule, value)
  score += audit_classify_integrity(parcel, rule, value)
  score += audit_project_event(parcel, rule, value)
  score += audit_project_trace(parcel, rule, value)
  score += audit_project_explain(parcel, rule, value)
  score += audit_project_decision(parcel, rule, value)
  score += audit_project_source(parcel, rule, value)
  score += audit_project_sequence(parcel, rule, value)
  score += audit_project_exception(parcel, rule, value)
  score += audit_project_evidence(parcel, rule, value)
  score += audit_project_integrity(parcel, rule, value)
  score += audit_reserve_event(parcel, rule, value)
  score += audit_reserve_trace(parcel, rule, value)
  score += audit_reserve_explain(parcel, rule, value)
  score += audit_reserve_decision(parcel, rule, value)
  score += audit_reserve_source(parcel, rule, value)
  score += audit_reserve_sequence(parcel, rule, value)
  score += audit_reserve_exception(parcel, rule, value)
  score += audit_reserve_evidence(parcel, rule, value)
  score += audit_reserve_integrity(parcel, rule, value)
  score += audit_reconcile_event(parcel, rule, value)
  score += audit_reconcile_trace(parcel, rule, value)
  score += audit_reconcile_explain(parcel, rule, value)
  score += audit_reconcile_decision(parcel, rule, value)
  score += audit_reconcile_source(parcel, rule, value)
  score += audit_reconcile_sequence(parcel, rule, value)
  score += audit_reconcile_exception(parcel, rule, value)
  score += audit_reconcile_evidence(parcel, rule, value)
  score += audit_reconcile_integrity(parcel, rule, value)
  score += audit_rank_event(parcel, rule, value)
  score += audit_rank_trace(parcel, rule, value)
  score += audit_rank_explain(parcel, rule, value)
  score += audit_rank_decision(parcel, rule, value)
  score += audit_rank_source(parcel, rule, value)
  score += audit_rank_sequence(parcel, rule, value)
  score += audit_rank_exception(parcel, rule, value)
  score += audit_rank_evidence(parcel, rule, value)
  score += audit_rank_integrity(parcel, rule, value)
  score
}
