///|
pub fn summarize_manifest(values : Array[ParcelDim]) -> ManifestSummary {
  if values.is_empty() {
    {
      count: 0,
      total_weight_g: 0,
      average_weight_g: 0,
      max_weight_g: 0,
      min_weight_g: 0,
      outlier_count: 0,
    }
  } else {
    let mut total = 0
    let mut maximum = values[0].weight_g
    let mut minimum = values[0].weight_g
    for item in values {
      total += item.weight_g
      maximum = maximum.max(item.weight_g)
      minimum = minimum.min(item.weight_g)
    }
    let average = total / values.length()
    let ordered = values.map(fn(item) { item.weight_g })
    ordered.sort()
    let median = ordered[ordered.length() / 2]
    let mut outliers = 0
    for item in values {
      if item.weight_g > median * 3 {
        outliers += 1
      }
    }
    {
      count: values.length(),
      total_weight_g: total,
      average_weight_g: average,
      max_weight_g: maximum,
      min_weight_g: minimum,
      outlier_count: outliers,
    }
  }
}

///|
pub fn ManifestSummary::weight_range(self : ManifestSummary) -> Int {
  self.max_weight_g - self.min_weight_g
}

///|
pub fn ManifestSummary::is_empty(self : ManifestSummary) -> Bool {
  self.count == 0
}

///|
pub fn ManifestSummary::average_kg(self : ManifestSummary) -> Int {
  self.average_weight_g / 1000
}
