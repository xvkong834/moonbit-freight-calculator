///|
pub fn tariff_candidate(
  id : String,
  priority : Int,
  effective_from : Int,
  effective_to : Int,
  predicates : Array[TariffPredicate],
  charge : Money,
) -> TariffCandidate {
  { id, priority, effective_from, effective_to, predicates, charge }
}

///|
fn predicate_matches(
  predicate : TariffPredicate,
  parcel : ParcelDim,
  zone : String,
  declared_value : Money,
) -> Bool {
  match predicate {
    WeightAtLeast(value) => parcel.weight_g >= value
    WeightAtMost(value) => parcel.weight_g <= value
    LongestSideAtMost(value) => parcel.longest_side_cm() <= value
    ZoneIs(expected) => zone == expected
    DeclaredValueAtLeast(value) => declared_value.cents >= value.cents
  }
}

///|
fn candidate_matches(
  candidate : TariffCandidate,
  parcel : ParcelDim,
  zone : String,
  declared_value : Money,
  day : Int,
) -> Bool {
  if day < candidate.effective_from || day > candidate.effective_to {
    false
  } else {
    let mut matches = true
    for predicate in candidate.predicates {
      if !predicate_matches(predicate, parcel, zone, declared_value) {
        matches = false
      }
    }
    matches
  }
}

///|
pub fn choose_tariff(
  candidates : Array[TariffCandidate],
  parcel : ParcelDim,
  zone : String,
  declared_value : Money,
  day : Int,
) -> DecisionTrace {
  let mut selected = ""
  let mut selected_priority = -1
  let mut considered = 0
  let rejected : Array[String] = []
  let reasons : Array[String] = []
  for candidate in candidates {
    considered += 1
    if candidate_matches(candidate, parcel, zone, declared_value, day) {
      if candidate.priority > selected_priority {
        if selected.length() > 0 {
          rejected.push(selected)
        }
        selected = candidate.id
        selected_priority = candidate.priority
      } else {
        rejected.push(candidate.id)
      }
    } else {
      rejected.push(candidate.id)
    }
  }
  if selected.length() == 0 {
    reasons.push("no applicable candidate")
  } else {
    reasons.push("highest priority applicable candidate")
  }
  { selected, considered, rejected, reasons }
}

///|
pub fn TariffCandidate::is_well_formed(self : TariffCandidate) -> Bool {
  self.id.length() > 0 &&
  self.priority >= 0 &&
  self.effective_to >= self.effective_from &&
  self.charge.cents >= 0
}

///|
pub fn TariffCandidate::active_on(self : TariffCandidate, day : Int) -> Bool {
  day >= self.effective_from && day <= self.effective_to
}

///|
pub fn DecisionTrace::has_selection(self : DecisionTrace) -> Bool {
  self.selected.length() > 0
}

///|
pub fn DecisionTrace::rejection_count(self : DecisionTrace) -> Int {
  self.rejected.length()
}

///|
pub fn DecisionTrace::explanation(self : DecisionTrace) -> String {
  if self.selected.length() == 0 {
    "no tariff selected"
  } else {
    "selected=" + self.selected + " reason=" + self.reasons[0]
  }
}
