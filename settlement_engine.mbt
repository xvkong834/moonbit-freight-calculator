///|
pub fn settlement_line(
  code : String,
  amount : Money,
  taxable : Bool,
) -> SettlementLine {
  { code, amount, taxable }
}

///|
pub fn invoice(
  id : String,
  lines : Array[SettlementLine],
  tax : Money,
  paid : Money,
) -> Invoice {
  { id, lines, tax, paid }
}

///|
pub fn invoice_subtotal(invoice : Invoice) -> Money {
  let mut total = Money::zero()
  for line in invoice.lines {
    total = total.add(line.amount)
  }
  total
}

///|
pub fn invoice_total(invoice : Invoice) -> Money {
  invoice_subtotal(invoice).add(invoice.tax)
}

///|
pub fn invoice_outstanding(invoice : Invoice) -> Money {
  invoice_total(invoice).sub(invoice.paid).max(Money::zero())
}

///|
pub fn invoice_balance(invoice : Invoice) -> (BalanceState, Money) {
  let total = invoice_total(invoice)
  if invoice.paid.cents <= 0 {
    (Unpaid, total)
  } else if invoice.paid.cents < total.cents {
    (PartiallyPaid, invoice_outstanding(invoice))
  } else if invoice.paid.cents == total.cents {
    (Paid, Money::zero())
  } else {
    (Overpaid, invoice.paid.sub(total))
  }
}

///|
pub fn Invoice::taxable_subtotal(self : Invoice) -> Money {
  let mut total = Money::zero()
  for line in self.lines {
    if line.taxable {
      total = total.add(line.amount)
    }
  }
  total
}

///|
pub fn Invoice::line_count(self : Invoice) -> Int {
  self.lines.length()
}

///|
pub fn Invoice::is_closed(self : Invoice) -> Bool {
  match invoice_balance(self).0 {
    Paid => true
    Overpaid => true
    _ => false
  }
}

///|
pub fn allocate_payment(
  invoice : Invoice,
  payment_id : String,
  amount : Money,
) -> PaymentAllocation {
  let remaining = invoice_outstanding(invoice)
    .sub(amount.max(Money::zero()))
    .max(Money::zero())
  {
    payment_id,
    invoice_id: invoice.id,
    amount: amount.max(Money::zero()).min(invoice_outstanding(invoice)),
    remaining,
  }
}

///|
pub fn PaymentAllocation::fully_settles(self : PaymentAllocation) -> Bool {
  self.remaining.is_zero()
}

///|
pub fn BalanceState::is_terminal(self : BalanceState) -> Bool {
  match self {
    Paid => true
    Overpaid => true
    _ => false
  }
}
