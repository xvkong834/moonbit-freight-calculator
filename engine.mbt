///|
pub fn quote(
  rule : BillingRule,
  parcel : ParcelDim,
  zone : String,
  declared_value : Money,
) -> Quote {
  let billable = billable_weight_g(parcel, rule.volumetric_divisor)
  let volumetric = volumetric_weight_g(parcel, rule.volumetric_divisor)
  let lines : Array[ChargeLine] = []
  lines.push(Base(weight_g=rule.first_weight_limit_g, rule.first_weight_rate))
  let extra_weight = (billable - rule.first_weight_limit_g).max(0)
  let extra_units = div_ceil(extra_weight, rule.additional_weight_unit_g)
  if extra_units > 0 {
    lines.push(
      Additional(
        units=extra_units,
        rule.additional_weight_rate.mul_int(extra_units),
      ),
    )
  }
  let zone_rate = rule.zone_rate(zone)
  let base = rule.first_weight_rate.add(
    rule.additional_weight_rate.mul_int(extra_units),
  )
  let zoned = base.scale_bp(zone_rate.multiplier_bp)
  if zone_rate.multiplier_bp != 10000 {
    lines.push(
      Zone(
        zone=zone_rate.zone,
        multiplier_bp=zone_rate.multiplier_bp,
        zoned.sub(base),
      ),
    )
  }
  if zone_rate.remote_fee.cents > 0 {
    lines.push(Remote(zone=zone_rate.zone, zone_rate.remote_fee))
  }
  let mut subtotal = zoned.add(zone_rate.remote_fee)
  if billable > rule.surcharge.overweight_limit_g {
    subtotal = subtotal.add(rule.surcharge.overweight_fee)
    lines.push(
      Overweight(
        limit_g=rule.surcharge.overweight_limit_g,
        rule.surcharge.overweight_fee,
      ),
    )
  }
  if parcel.longest_side_cm() > rule.surcharge.oversize_limit_cm {
    subtotal = subtotal.add(rule.surcharge.oversize_fee)
    lines.push(
      Oversize(
        limit_cm=rule.surcharge.oversize_limit_cm,
        rule.surcharge.oversize_fee,
      ),
    )
  }
  let fuel = subtotal.percent_bp(rule.surcharge.fuel_percent_bp)
  if fuel.cents > 0 {
    subtotal = subtotal.add(fuel)
    lines.push(Fuel(percent_bp=rule.surcharge.fuel_percent_bp, fuel))
  }
  let insurance = declared_value.percent_bp(rule.surcharge.insurance_percent_bp)
  if insurance.cents > 0 {
    subtotal = subtotal.add(insurance)
    lines.push(
      Insurance(
        percent_bp=rule.surcharge.insurance_percent_bp,
        declared_value~,
        insurance,
      ),
    )
  }
  let total = subtotal.max(rule.min_charge)
  if total.cents != subtotal.cents {
    lines.push(Minimum(total.sub(subtotal)))
  }
  {
    billable_weight_g: billable,
    actual_weight_g: parcel.weight_g,
    volumetric_weight_g: volumetric,
    subtotal,
    total,
    lines,
  }
}

///|
pub fn quote_manifest(
  rule : BillingRule,
  items : Array[ManifestItem],
) -> ManifestQuote {
  let quotes : Array[Quote] = []
  let mut total = Money::zero()
  for item in items {
    let q = quote(rule, item.parcel, item.zone, item.declared_value)
    total = total.add(q.total)
    quotes.push(q)
  }
  { items: quotes, total }
}
