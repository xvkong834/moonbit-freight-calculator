///|
fn main {
  let rule = @freight.standard_rule()
  let items = @freight.sample_manifest()
  let mut total = @freight.Money::zero()
  let mut rounds = 0
  for _ in 0..<1000 {
    for item in items {
      let result = @freight.quote(
        rule,
        item.parcel,
        item.zone,
        item.declared_value,
      )
      total = total.add(result.total)
      rounds += 1
    }
  }
  println("items=" + rounds.to_string() + " total=" + total.to_string())
}
