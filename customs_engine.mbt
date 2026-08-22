///|
pub fn customs_line(
  code : String,
  declared_value : Money,
  duty_bp : Int,
  insurance_bp : Int,
) -> CustomsLine {
  {
    code,
    declared_value,
    duty_bp: duty_bp.max(0),
    insurance_bp: insurance_bp.max(0),
  }
}

///|
pub fn customs_duty(line : CustomsLine) -> Money {
  line.declared_value.percent_bp(line.duty_bp)
}

///|
pub fn customs_insurance(line : CustomsLine) -> Money {
  line.declared_value.percent_bp(line.insurance_bp)
}

///|
pub fn calculate_customs(lines : Array[CustomsLine]) -> CustomsSummary {
  let mut declared = Money::zero()
  let mut duty = Money::zero()
  let mut insurance = Money::zero()
  for line in lines {
    declared = declared.add(line.declared_value.max(Money::zero()))
    duty = duty.add(customs_duty(line))
    insurance = insurance.add(customs_insurance(line))
  }
  {
    declared_value: declared,
    duty,
    insurance,
    total: declared.add(duty).add(insurance),
  }
}

///|
pub fn CustomsLine::is_valid(self : CustomsLine) -> Bool {
  self.code.length() > 0 &&
  self.declared_value.cents >= 0 &&
  self.duty_bp <= 10000 &&
  self.insurance_bp <= 10000
}

///|
pub fn CustomsSummary::effective_duty_bp(self : CustomsSummary) -> Int {
  if self.declared_value.cents <= 0 {
    0
  } else {
    self.duty.cents * 10000 / self.declared_value.cents
  }
}

///|
pub fn CustomsSummary::is_empty(self : CustomsSummary) -> Bool {
  self.declared_value.is_zero() &&
  self.duty.is_zero() &&
  self.insurance.is_zero()
}
