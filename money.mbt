///|
pub fn Money::from_cents(cents : Int) -> Money {
  { cents, }
}

///|
pub fn Money::yuan(yuan : Int) -> Money {
  { cents: yuan * 100 }
}

///|
pub fn Money::zero() -> Money {
  { cents: 0 }
}

///|
pub fn Money::add(self : Money, other : Money) -> Money {
  { cents: self.cents + other.cents }
}

///|
pub fn Money::sub(self : Money, other : Money) -> Money {
  { cents: self.cents - other.cents }
}

///|
pub fn Money::mul_int(self : Money, n : Int) -> Money {
  { cents: self.cents * n }
}

///|
pub fn Money::percent_bp(self : Money, bp : Int) -> Money {
  { cents: div_ceil(self.cents * bp, 10000) }
}

///|
pub fn Money::scale_bp(self : Money, bp : Int) -> Money {
  { cents: div_ceil(self.cents * bp, 10000) }
}

///|
pub fn Money::max(self : Money, other : Money) -> Money {
  if self.cents >= other.cents {
    self
  } else {
    other
  }
}

///|
pub fn Money::to_string(self : Money) -> String {
  let yuan = self.cents / 100
  let fen = self.cents % 100
  let fen_text = if fen < 10 { "0\{fen}" } else { "\{fen}" }
  "CNY \{yuan}.\{fen_text}"
}

///|
fn div_ceil(value : Int, by : Int) -> Int {
  if value <= 0 {
    0
  } else {
    (value + by - 1) / by
  }
}
