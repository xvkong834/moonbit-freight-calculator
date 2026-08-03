///|
pub fn Quote::summary(self : Quote) -> String {
  "billable=\{self.billable_weight_g}g total=\{self.total.to_string()} lines=\{self.lines.length()}"
}

///|
pub fn ManifestQuote::summary(self : ManifestQuote) -> String {
  "items=\{self.items.length()} total=\{self.total.to_string()}"
}

///|
pub fn describe_line(line : ChargeLine) -> String {
  match line {
    Base(weight_g~, money) => "base <=\{weight_g}g \{money.to_string()}"
    Additional(units~, money) => "additional x\{units} \{money.to_string()}"
    Zone(zone~, multiplier_bp~, money) =>
      "zone \{zone} +\{multiplier_bp - 10000}bp \{money.to_string()}"
    Remote(zone~, money) => "remote \{zone} \{money.to_string()}"
    Overweight(limit_g~, money) =>
      "overweight >\{limit_g}g \{money.to_string()}"
    Oversize(limit_cm~, money) => "oversize >\{limit_cm}cm \{money.to_string()}"
    Fuel(percent_bp~, money) => "fuel \{percent_bp}bp \{money.to_string()}"
    Insurance(percent_bp~, declared_value~, money) =>
      "insurance \{percent_bp}bp of \{declared_value.to_string()} \{money.to_string()}"
    Minimum(money) => "minimum adjustment \{money.to_string()}"
  }
}
