///|
pub fn discount_rule(
  code~ : String,
  percent_bp~ : Int,
  cap~ : Money,
) -> DiscountRule {
  { code, percent_bp, cap }
}

///|
pub fn apply_discounts(
  original : Money,
  rules : Array[DiscountRule],
) -> DiscountResult {
  let mut discount = Money::zero()
  let applied : Array[String] = []
  for rule in rules {
    let candidate = original
      .percent_bp(rule.percent_bp.max(0))
      .min(rule.cap.max(Money::zero()))
    discount = discount.add(candidate)
    if candidate.is_positive() {
      applied.push(rule.code)
    }
  }
  let payable = original.sub(discount).max(Money::zero())
  { original, discount, payable, applied }
}

///|
pub fn DiscountRule::valid(self : DiscountRule) -> Bool {
  self.code.length() > 0 &&
  self.percent_bp >= 0 &&
  self.percent_bp <= 10000 &&
  self.cap.cents >= 0
}

///|
pub fn DiscountResult::effective_rate_bp(self : DiscountResult) -> Int {
  if self.original.cents <= 0 {
    0
  } else {
    self.discount.cents * 10000 / self.original.cents
  }
}

///|
pub fn combine_discount_rules(
  groups : Array[Array[DiscountRule]],
) -> Array[DiscountRule] {
  let result : Array[DiscountRule] = []
  for group in groups {
    for rule in group {
      result.push(rule)
    }
  }
  result
}
