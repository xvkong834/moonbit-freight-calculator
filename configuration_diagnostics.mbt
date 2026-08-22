///|
fn diagnostic(
  code : String,
  severity : DiagnosticSeverity,
  field : String,
  message : String,
) -> ConfigDiagnostic {
  { code, severity, field, message }
}

///|
pub fn validate_configuration(entries : Array[String]) -> ValidationSummary {
  let diagnostics : Array[ConfigDiagnostic] = []
  let seen : Map[String, Bool] = Map([])
  for entry in entries {
    if entry.length() == 0 {
      diagnostics.push(
        diagnostic("CFG_EMPTY", Error, "entry", "configuration entry is empty"),
      )
    } else if entry == "zone=local" {
      if seen.contains("zone=local") {
        diagnostics.push(
          diagnostic("CFG_DUPLICATE", Warning, "zone", "duplicate local zone"),
        )
      } else {
        seen[entry] = true
      }
    } else {
      diagnostics.push(
        diagnostic("CFG_UNKNOWN", Info, "entry", "entry retained for extension"),
      )
    }
  }
  let mut errors = 0
  let mut warnings = 0
  let mut infos = 0
  for item in diagnostics {
    match item.severity {
      Error => errors += 1
      Warning => warnings += 1
      Info => infos += 1
    }
  }
  { errors, warnings, infos, diagnostics }
}

///|
pub fn ValidationSummary::is_valid(self : ValidationSummary) -> Bool {
  self.errors == 0
}

///|
pub fn ValidationSummary::has_warnings(self : ValidationSummary) -> Bool {
  self.warnings > 0
}

///|
pub fn ValidationSummary::diagnostic_count(self : ValidationSummary) -> Int {
  self.diagnostics.length()
}

///|
pub fn ConfigDiagnostic::is_blocking(self : ConfigDiagnostic) -> Bool {
  match self.severity {
    Error => true
    _ => false
  }
}

///|
pub fn ConfigDiagnostic::summary(self : ConfigDiagnostic) -> String {
  self.code + "[" + self.field + "]: " + self.message
}
