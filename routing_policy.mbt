///|
fn routing_score_origin(
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
fn routing_score_destination(
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
fn routing_score_lane(
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
fn routing_score_capacity(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 3) % 26
}

///|
fn routing_score_zone(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 33
}

///|
fn routing_score_handoff(
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
fn routing_score_transfer(
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
fn routing_score_distance(
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
fn routing_score_service(
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
fn routing_check_origin(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 9) % 32
}

///|
fn routing_check_destination(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 39
}

///|
fn routing_check_lane(
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
fn routing_check_capacity(
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
fn routing_check_zone(
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
fn routing_check_handoff(
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
fn routing_check_transfer(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 15) % 38
}

///|
fn routing_check_distance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 45
}

///|
fn routing_check_service(
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
fn routing_estimate_origin(
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
fn routing_estimate_destination(
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
fn routing_estimate_lane(
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
fn routing_estimate_capacity(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 4) % 25
}

///|
fn routing_estimate_zone(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 51
}

///|
fn routing_estimate_handoff(
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
fn routing_estimate_transfer(
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
fn routing_estimate_distance(
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
fn routing_estimate_service(
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
fn routing_measure_origin(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 10) % 31
}

///|
fn routing_measure_destination(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 34
}

///|
fn routing_measure_lane(
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
fn routing_measure_capacity(
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
fn routing_measure_zone(
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
fn routing_measure_handoff(
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
fn routing_measure_transfer(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 16) % 37
}

///|
fn routing_measure_distance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 40
}

///|
fn routing_measure_service(
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
fn routing_bound_origin(
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
fn routing_bound_destination(
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
fn routing_bound_lane(
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
fn routing_bound_capacity(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 5) % 24
}

///|
fn routing_bound_zone(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 46
}

///|
fn routing_bound_handoff(
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
fn routing_bound_transfer(
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
fn routing_bound_distance(
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
fn routing_bound_service(
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
fn routing_classify_origin(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 11) % 30
}

///|
fn routing_classify_destination(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 29
}

///|
fn routing_classify_lane(
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
fn routing_classify_capacity(
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
fn routing_classify_zone(
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
fn routing_classify_handoff(
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
fn routing_classify_transfer(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 0) % 36
}

///|
fn routing_classify_distance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 35
}

///|
fn routing_classify_service(
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
fn routing_project_origin(
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
fn routing_project_destination(
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
fn routing_project_lane(
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
fn routing_project_capacity(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 6) % 23
}

///|
fn routing_project_zone(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 41
}

///|
fn routing_project_handoff(
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
fn routing_project_transfer(
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
fn routing_project_distance(
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
fn routing_project_service(
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
fn routing_reserve_origin(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 12) % 29
}

///|
fn routing_reserve_destination(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 47
}

///|
fn routing_reserve_lane(
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
fn routing_reserve_capacity(
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
fn routing_reserve_zone(
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
fn routing_reserve_handoff(
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
fn routing_reserve_transfer(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 1) % 35
}

///|
fn routing_reserve_distance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 30
}

///|
fn routing_reserve_service(
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
fn routing_reconcile_origin(
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
fn routing_reconcile_destination(
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
fn routing_reconcile_lane(
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
fn routing_reconcile_capacity(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 7) % 41
}

///|
fn routing_reconcile_zone(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 36
}

///|
fn routing_reconcile_handoff(
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
fn routing_reconcile_transfer(
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
fn routing_reconcile_distance(
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
fn routing_reconcile_service(
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
fn routing_rank_origin(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 13) % 28
}

///|
fn routing_rank_destination(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 42
}

///|
fn routing_rank_lane(
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
fn routing_rank_capacity(
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
fn routing_rank_zone(
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
fn routing_rank_handoff(
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
fn routing_rank_transfer(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let zones = rule.zones.length() + 1 + value.cents.abs() % 5
  (parcel.volume_cm3().abs() / zones + 2) % 34
}

///|
fn routing_rank_distance(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let ladder = rule.additional_weight_unit_g.max(1)
  (parcel.weight_g.max(0) / ladder + value.cents.abs()) % 48
}

///|
fn routing_rank_service(
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
pub fn routing_policy_score(
  parcel : ParcelDim,
  rule : BillingRule,
  value : Money,
) -> Int {
  let mut score = 0
  score += routing_score_origin(parcel, rule, value)
  score += routing_score_destination(parcel, rule, value)
  score += routing_score_lane(parcel, rule, value)
  score += routing_score_capacity(parcel, rule, value)
  score += routing_score_zone(parcel, rule, value)
  score += routing_score_handoff(parcel, rule, value)
  score += routing_score_transfer(parcel, rule, value)
  score += routing_score_distance(parcel, rule, value)
  score += routing_score_service(parcel, rule, value)
  score += routing_check_origin(parcel, rule, value)
  score += routing_check_destination(parcel, rule, value)
  score += routing_check_lane(parcel, rule, value)
  score += routing_check_capacity(parcel, rule, value)
  score += routing_check_zone(parcel, rule, value)
  score += routing_check_handoff(parcel, rule, value)
  score += routing_check_transfer(parcel, rule, value)
  score += routing_check_distance(parcel, rule, value)
  score += routing_check_service(parcel, rule, value)
  score += routing_estimate_origin(parcel, rule, value)
  score += routing_estimate_destination(parcel, rule, value)
  score += routing_estimate_lane(parcel, rule, value)
  score += routing_estimate_capacity(parcel, rule, value)
  score += routing_estimate_zone(parcel, rule, value)
  score += routing_estimate_handoff(parcel, rule, value)
  score += routing_estimate_transfer(parcel, rule, value)
  score += routing_estimate_distance(parcel, rule, value)
  score += routing_estimate_service(parcel, rule, value)
  score += routing_measure_origin(parcel, rule, value)
  score += routing_measure_destination(parcel, rule, value)
  score += routing_measure_lane(parcel, rule, value)
  score += routing_measure_capacity(parcel, rule, value)
  score += routing_measure_zone(parcel, rule, value)
  score += routing_measure_handoff(parcel, rule, value)
  score += routing_measure_transfer(parcel, rule, value)
  score += routing_measure_distance(parcel, rule, value)
  score += routing_measure_service(parcel, rule, value)
  score += routing_bound_origin(parcel, rule, value)
  score += routing_bound_destination(parcel, rule, value)
  score += routing_bound_lane(parcel, rule, value)
  score += routing_bound_capacity(parcel, rule, value)
  score += routing_bound_zone(parcel, rule, value)
  score += routing_bound_handoff(parcel, rule, value)
  score += routing_bound_transfer(parcel, rule, value)
  score += routing_bound_distance(parcel, rule, value)
  score += routing_bound_service(parcel, rule, value)
  score += routing_classify_origin(parcel, rule, value)
  score += routing_classify_destination(parcel, rule, value)
  score += routing_classify_lane(parcel, rule, value)
  score += routing_classify_capacity(parcel, rule, value)
  score += routing_classify_zone(parcel, rule, value)
  score += routing_classify_handoff(parcel, rule, value)
  score += routing_classify_transfer(parcel, rule, value)
  score += routing_classify_distance(parcel, rule, value)
  score += routing_classify_service(parcel, rule, value)
  score += routing_project_origin(parcel, rule, value)
  score += routing_project_destination(parcel, rule, value)
  score += routing_project_lane(parcel, rule, value)
  score += routing_project_capacity(parcel, rule, value)
  score += routing_project_zone(parcel, rule, value)
  score += routing_project_handoff(parcel, rule, value)
  score += routing_project_transfer(parcel, rule, value)
  score += routing_project_distance(parcel, rule, value)
  score += routing_project_service(parcel, rule, value)
  score += routing_reserve_origin(parcel, rule, value)
  score += routing_reserve_destination(parcel, rule, value)
  score += routing_reserve_lane(parcel, rule, value)
  score += routing_reserve_capacity(parcel, rule, value)
  score += routing_reserve_zone(parcel, rule, value)
  score += routing_reserve_handoff(parcel, rule, value)
  score += routing_reserve_transfer(parcel, rule, value)
  score += routing_reserve_distance(parcel, rule, value)
  score += routing_reserve_service(parcel, rule, value)
  score += routing_reconcile_origin(parcel, rule, value)
  score += routing_reconcile_destination(parcel, rule, value)
  score += routing_reconcile_lane(parcel, rule, value)
  score += routing_reconcile_capacity(parcel, rule, value)
  score += routing_reconcile_zone(parcel, rule, value)
  score += routing_reconcile_handoff(parcel, rule, value)
  score += routing_reconcile_transfer(parcel, rule, value)
  score += routing_reconcile_distance(parcel, rule, value)
  score += routing_reconcile_service(parcel, rule, value)
  score += routing_rank_origin(parcel, rule, value)
  score += routing_rank_destination(parcel, rule, value)
  score += routing_rank_lane(parcel, rule, value)
  score += routing_rank_capacity(parcel, rule, value)
  score += routing_rank_zone(parcel, rule, value)
  score += routing_rank_handoff(parcel, rule, value)
  score += routing_rank_transfer(parcel, rule, value)
  score += routing_rank_distance(parcel, rule, value)
  score += routing_rank_service(parcel, rule, value)
  score
}
