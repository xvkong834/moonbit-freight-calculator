///|
pub fn zone_rate(
  zone~ : String,
  multiplier_bp~ : Int,
  remote_fee~ : Money,
) -> ZoneRate {
  { zone, multiplier_bp, remote_fee }
}

///|
pub fn surcharge_policy(
  overweight_limit_g~ : Int,
  overweight_fee~ : Money,
  oversize_limit_cm~ : Int,
  oversize_fee~ : Money,
  fuel_percent_bp~ : Int,
  insurance_percent_bp~ : Int,
) -> SurchargePolicy {
  {
    overweight_limit_g,
    overweight_fee,
    oversize_limit_cm,
    oversize_fee,
    fuel_percent_bp,
    insurance_percent_bp,
  }
}

///|
pub fn billing_rule(
  volumetric_divisor~ : Int,
  first_weight_limit_g~ : Int,
  first_weight_rate~ : Money,
  additional_weight_unit_g~ : Int,
  additional_weight_rate~ : Money,
  min_charge~ : Money,
  zones~ : Array[ZoneRate],
  surcharge~ : SurchargePolicy,
) -> BillingRule {
  {
    volumetric_divisor,
    first_weight_limit_g,
    first_weight_rate,
    additional_weight_unit_g,
    additional_weight_rate,
    min_charge,
    zones,
    surcharge,
  }
}

///|
pub fn standard_rule() -> BillingRule {
  billing_rule(
    volumetric_divisor=6000,
    first_weight_limit_g=1000,
    first_weight_rate=Money::yuan(12),
    additional_weight_unit_g=500,
    additional_weight_rate=Money::yuan(4),
    min_charge=Money::yuan(10),
    zones=[
      zone_rate(zone="local", multiplier_bp=10000, remote_fee=Money::zero()),
      zone_rate(zone="regional", multiplier_bp=11800, remote_fee=Money::zero()),
      zone_rate(zone="remote", multiplier_bp=13800, remote_fee=Money::yuan(8)),
    ],
    surcharge=surcharge_policy(
      overweight_limit_g=20000,
      overweight_fee=Money::yuan(30),
      oversize_limit_cm=120,
      oversize_fee=Money::yuan(18),
      fuel_percent_bp=350,
      insurance_percent_bp=80,
    ),
  )
}

///|
pub fn BillingRule::zone_rate(self : BillingRule, zone : String) -> ZoneRate {
  for z in self.zones {
    if z.zone == zone {
      break z
    }
  } nobreak {
    zone_rate(zone~, multiplier_bp=10000, remote_fee=Money::zero())
  }
}
