///|
fn find_line(lines : Array[SettlementLine], code : String) -> SettlementLine? {
  for line in lines {
    if line.code == code {
      break Some(line)
    }
  } nobreak {
    None
  }
}

///|
pub fn reconcile_lines(
  expected : Array[SettlementLine],
  actual : Array[SettlementLine],
  tolerance : Money,
) -> ReconciliationReport {
  let items : Array[ReconciliationItem] = []
  let mut matched = 0
  let mut exceptions = 0
  let mut net = Money::zero()
  for line in expected {
    match find_line(actual, line.code) {
      Some(other) => {
        let difference = other.amount.sub(line.amount)
        let status = if difference.abs().cents <= tolerance.abs().cents {
          Matched
        } else {
          Difference
        }
        if status == Matched {
          matched += 1
        } else {
          exceptions += 1
        }
        net = net.add(difference)
        items.push({
          code: line.code,
          expected: line.amount,
          actual: other.amount,
          difference,
          status,
        })
      }
      None => {
        exceptions += 1
        net = net.sub(line.amount)
        items.push({
          code: line.code,
          expected: line.amount,
          actual: Money::zero(),
          difference: line.amount.negate(),
          status: MissingExpected,
        })
      }
    }
  }
  for line in actual {
    if find_line(expected, line.code) is None {
      exceptions += 1
      net = net.add(line.amount)
      items.push({
        code: line.code,
        expected: Money::zero(),
        actual: line.amount,
        difference: line.amount,
        status: UnexpectedActual,
      })
    }
  }
  { items, matched, exceptions, net_difference: net }
}

///|
pub fn ReconciliationReport::is_matched(self : ReconciliationReport) -> Bool {
  self.exceptions == 0
}

///|
pub fn ReconciliationReport::item_count(self : ReconciliationReport) -> Int {
  self.items.length()
}

///|
pub fn ReconciliationReport::absolute_difference(
  self : ReconciliationReport,
) -> Money {
  self.net_difference.abs()
}
