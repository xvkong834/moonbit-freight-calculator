///|
pub fn tax_policy(rate_bp~ : Int, threshold~ : Money) -> TaxPolicy {
  { rate_bp, threshold }
}

///|
pub fn calculate_tax(
  policy : TaxPolicy,
  taxable : Money,
  exempt : Money,
) -> TaxResult {
  let basis = taxable.max(Money::zero()).max(policy.threshold)
  let tax = basis.percent_bp(policy.rate_bp.max(0))
  {
    taxable: basis,
    exempt: exempt.max(Money::zero()),
    tax,
    gross: basis.add(exempt.max(Money::zero())).add(tax),
  }
}

///|
pub fn TaxPolicy::valid(self : TaxPolicy) -> Bool {
  self.rate_bp >= 0 && self.rate_bp <= 10000 && self.threshold.cents >= 0
}

///|
pub fn TaxResult::net_of_tax(self : TaxResult) -> Money {
  self.gross.sub(self.tax)
}
