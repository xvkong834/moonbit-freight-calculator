///|
fn aging_band(days_overdue : Int) -> AgingBand {
  if days_overdue <= 0 {
    Current
  } else if days_overdue <= 7 {
    Days1To7
  } else if days_overdue <= 30 {
    Days8To30
  } else if days_overdue <= 60 {
    Days31To60
  } else {
    Over60
  }
}

///|
fn aging_amount(
  band : AgingBand,
  selected : AgingBand,
  amount : Money,
) -> Money {
  if band == selected {
    amount
  } else {
    Money::zero()
  }
}

///|
pub fn invoice_aging(
  invoice : Invoice,
  invoice_day : Int,
  as_of_day : Int,
) -> Array[AgingBucket] {
  let overdue = (as_of_day - invoice_day).max(0)
  let band = aging_band(overdue)
  let amount = invoice_outstanding(invoice)
  [
    { band: Current, amount: aging_amount(Current, band, amount) },
    { band: Days1To7, amount: aging_amount(Days1To7, band, amount) },
    { band: Days8To30, amount: aging_amount(Days8To30, band, amount) },
    { band: Days31To60, amount: aging_amount(Days31To60, band, amount) },
    { band: Over60, amount: aging_amount(Over60, band, amount) },
  ]
}

///|
pub fn AgingBucket::is_empty(self : AgingBucket) -> Bool {
  self.amount.is_zero()
}

///|
pub fn AgingBucket::band_name(self : AgingBucket) -> String {
  match self.band {
    Current => "current"
    Days1To7 => "1-7"
    Days8To30 => "8-30"
    Days31To60 => "31-60"
    Over60 => "over-60"
  }
}

///|
pub fn aging_total(buckets : Array[AgingBucket]) -> Money {
  let mut total = Money::zero()
  for bucket in buckets {
    total = total.add(bucket.amount)
  }
  total
}

///|
pub fn aging_open_days(invoice_day : Int, as_of_day : Int) -> Int {
  (as_of_day - invoice_day).max(0)
}

///|
pub fn aging_is_overdue(invoice_day : Int, as_of_day : Int) -> Bool {
  aging_open_days(invoice_day, as_of_day) > 0
}
