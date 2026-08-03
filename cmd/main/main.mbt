///|
fn main {
  let quote = @freight.quote_manifest(
    @freight.standard_rule(),
    @freight.sample_manifest(),
  )
  println(quote.summary())
  for q in quote.items {
    println(q.summary())
  }
}
