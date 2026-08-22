///|
pub fn find_operational_rate(
  catalog : Array[OperationalRate],
  weight_g : Int,
) -> OperationalRate {
  for item in catalog {
    if weight_g >= item.minimum_g && weight_g <= item.maximum_g {
      break item
    }
  } nobreak {
    if catalog.is_empty() {
      {
        code: "empty",
        zone: "default",
        minimum_g: 0,
        maximum_g: 0,
        rate: Money::zero(),
        multiplier_bp: 10000,
      }
    } else {
      catalog[catalog.length() - 1]
    }
  }
}

///|
pub fn OperationalRate::contains(
  self : OperationalRate,
  weight_g : Int,
) -> Bool {
  weight_g >= self.minimum_g && weight_g <= self.maximum_g
}

///|
pub fn OperationalRate::is_valid(self : OperationalRate) -> Bool {
  self.code.length() > 0 &&
  self.zone.length() > 0 &&
  self.minimum_g >= 0 &&
  self.maximum_g >= self.minimum_g &&
  self.rate.cents >= 0 &&
  self.multiplier_bp > 0
}

///|
pub fn OperationalRate::span(self : OperationalRate) -> Int {
  self.maximum_g - self.minimum_g
}
