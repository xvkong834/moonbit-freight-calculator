///|
pub fn service_window(
  service : String,
  minimum_days : Int,
  maximum_days : Int,
  cutoff_hour : Int,
) -> ServiceWindow {
  { service, minimum_days, maximum_days, cutoff_hour }
}

///|
pub fn route_leg(
  origin : String,
  destination : String,
  zone : String,
  days : Int,
  capacity_g : Int,
) -> RouteLeg {
  { origin, destination, zone, days, capacity_g }
}

///|
pub fn audit_event(
  sequence : Int,
  code : String,
  detail : String,
  amount : Money,
) -> AuditEvent {
  { sequence, code, detail, amount }
}
