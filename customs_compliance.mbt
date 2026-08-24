///|
pub fn customs_document(
  hs_code : String,
  description : String,
  declared_value : Money,
  origin : String,
  restricted : Bool,
) -> CustomsDocument {
  { hs_code, description, declared_value, origin, restricted }
}

///|
fn customs_hs_code_valid(code : String) -> Bool {
  code.length() >= 4 && code.length() <= 10
}

///|
fn customs_reason(reasons : Array[String], reason : String) -> Unit {
  reasons.push(reason)
}

///|
pub fn assess_customs(
  document : CustomsDocument,
  duty_bp : Int,
) -> CustomsAssessment {
  let reasons : Array[String] = []
  let duty = document.declared_value
    .max(Money::zero())
    .percent_bp(duty_bp.max(0))
  if document.restricted {
    customs_reason(reasons, "restricted goods require an import permit")
    { decision: Reject, duty, reasons }
  } else {
    if !customs_hs_code_valid(document.hs_code) {
      customs_reason(reasons, "HS code length is outside the supported range")
    }
    if document.description.trim().length() < 3 {
      customs_reason(reasons, "description is too short for declaration")
    }
    if document.declared_value.cents < 0 {
      customs_reason(reasons, "declared value is negative")
    }
    if document.origin.trim().length() == 0 {
      customs_reason(reasons, "origin is missing")
    }
    {
      decision: if reasons.length() == 0 {
        Clear
      } else {
        Review
      },
      duty,
      reasons,
    }
  }
}

///|
pub fn CustomsAssessment::is_clear(self : CustomsAssessment) -> Bool {
  self.decision == Clear
}

///|
pub fn CustomsAssessment::requires_review(self : CustomsAssessment) -> Bool {
  self.decision == Review
}

///|
pub fn CustomsAssessment::is_rejected(self : CustomsAssessment) -> Bool {
  self.decision == Reject
}

///|
pub fn CustomsAssessment::reason_count(self : CustomsAssessment) -> Int {
  self.reasons.length()
}
