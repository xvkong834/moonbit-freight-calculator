///|
pub enum RuleProblem {
  NonPositiveDivisor
  NonPositiveWeightStep
  EmptyZones
  InvalidZoneMultiplier(String)
  NegativeFee(String)
} derive(Debug, Eq, ToJson)

///|
pub fn validate_rule(rule : BillingRule) -> Array[RuleProblem] {
  let problems : Array[RuleProblem] = []
  if rule.volumetric_divisor <= 0 {
    problems.push(NonPositiveDivisor)
  }
  if rule.additional_weight_unit_g <= 0 {
    problems.push(NonPositiveWeightStep)
  }
  if rule.zones.is_empty() {
    problems.push(EmptyZones)
  }
  if rule.first_weight_rate.cents < 0 {
    problems.push(NegativeFee("first_weight_rate"))
  }
  if rule.additional_weight_rate.cents < 0 {
    problems.push(NegativeFee("additional_weight_rate"))
  }
  for z in rule.zones {
    if z.multiplier_bp <= 0 {
      problems.push(InvalidZoneMultiplier(z.zone))
    }
    if z.remote_fee.cents < 0 {
      problems.push(NegativeFee("remote_fee:\{z.zone}"))
    }
  }
  problems
}
