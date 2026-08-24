///|
pub fn manifest_item(
  tracking_no : String,
  zone : String,
  parcel : ParcelDim,
  declared_value : Money,
) -> ManifestItem {
  { tracking_no, zone, parcel, declared_value }
}

///|
fn manifest_zone_known(zone : String) -> Bool {
  zone == "local" ||
  zone == "regional" ||
  zone == "remote" ||
  zone == "international"
}

///|
fn manifest_issue(
  item : ManifestItem,
  kind : ManifestIssueKind,
  detail : String,
) -> ManifestIssue {
  { tracking_no: item.tracking_no, kind, detail }
}

///|
fn validate_item(
  item : ManifestItem,
  seen : Map[String, Bool],
) -> Array[ManifestIssue] {
  let issues : Array[ManifestIssue] = []
  if item.tracking_no.trim().length() == 0 {
    issues.push(
      manifest_issue(item, MissingTracking, "tracking number is empty"),
    )
  } else if seen.contains(item.tracking_no) {
    issues.push(
      manifest_issue(item, DuplicateTracking, "tracking number is repeated"),
    )
  }
  if item.parcel.weight_g <= 0 {
    issues.push(manifest_issue(item, InvalidWeight, "weight must be positive"))
  }
  if item.declared_value.cents < 0 {
    issues.push(
      manifest_issue(
        item,
        InvalidDeclaredValue,
        "declared value must not be negative",
      ),
    )
  }
  if !manifest_zone_known(item.zone) {
    issues.push(manifest_issue(item, UnknownZone, "zone is not registered"))
  }
  issues
}

///|
pub fn validate_manifest(items : Array[ManifestItem]) -> ManifestValidation {
  let seen : Map[String, Bool] = Map([])
  let issues : Array[ManifestIssue] = []
  let mut accepted = 0
  for item in items {
    let item_issues = validate_item(item, seen)
    for issue in item_issues {
      issues.push(issue)
    }
    if item.tracking_no.trim().length() > 0 && !seen.contains(item.tracking_no) {
      seen[item.tracking_no] = true
    }
    if item_issues.length() == 0 {
      accepted += 1
    }
  }
  { valid: issues.length() == 0, issues, accepted }
}

///|
pub fn ManifestValidation::issue_count(self : ManifestValidation) -> Int {
  self.issues.length()
}

///|
pub fn ManifestValidation::is_empty(self : ManifestValidation) -> Bool {
  self.issues.length() == 0
}

///|
pub fn ManifestValidation::has_kind(
  self : ManifestValidation,
  kind : ManifestIssueKind,
) -> Bool {
  for issue in self.issues {
    if issue.kind == kind {
      return true
    }
  }
  false
}
