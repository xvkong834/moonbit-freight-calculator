///|
pub fn Money::round_to(
  self : Money,
  unit_cents : Int,
  mode : RoundingMode,
) -> Money {
  if unit_cents <= 0 {
    self
  } else {
    let quotient = self.cents / unit_cents
    let remainder = self.cents % unit_cents
    let rounded = match mode {
      Floor => quotient * unit_cents
      Ceiling =>
        if remainder == 0 {
          self.cents
        } else {
          (quotient + 1) * unit_cents
        }
      HalfUp =>
        if remainder * 2 >= unit_cents {
          (quotient + 1) * unit_cents
        } else {
          quotient * unit_cents
        }
      HalfDown =>
        if remainder * 2 > unit_cents {
          (quotient + 1) * unit_cents
        } else {
          quotient * unit_cents
        }
    }
    Money::from_cents(rounded)
  }
}

///|
pub fn Money::negate(self : Money) -> Money {
  Money::from_cents(0 - self.cents)
}

///|
pub fn Money::is_zero(self : Money) -> Bool {
  self.cents == 0
}

///|
pub fn Money::is_positive(self : Money) -> Bool {
  self.cents > 0
}

///|
pub fn Money::is_negative(self : Money) -> Bool {
  self.cents < 0
}

///|
pub fn Money::abs(self : Money) -> Money {
  if self.cents < 0 {
    self.negate()
  } else {
    self
  }
}

///|
pub fn Money::min(self : Money, other : Money) -> Money {
  if self.cents <= other.cents {
    self
  } else {
    other
  }
}

///|
pub fn Money::clamp(self : Money, low : Money, high : Money) -> Money {
  self.max(low).min(high)
}

///|
pub fn Money::difference(self : Money, other : Money) -> Money {
  self.sub(other).abs()
}
