///|
pub struct RouteEdge {
  from : String
  to : String
  distance_km : Int
  transit_days : Int
  capacity_g : Int
  zone : String
} derive(Debug, Eq, ToJson)

///|
pub struct RoutePlan {
  nodes : Array[String]
  distance_km : Int
  transit_days : Int
  capacity_g : Int
  feasible : Bool
} derive(Debug, Eq, ToJson)

///|
pub(all) enum AgingBand {
  Current
  Days1To7
  Days8To30
  Days31To60
  Over60
} derive(Debug, Eq, ToJson)

///|
pub struct AgingBucket {
  band : AgingBand
  amount : Money
} derive(Debug, Eq, ToJson)

///|
pub(all) enum ManifestIssueKind {
  MissingTracking
  DuplicateTracking
  InvalidWeight
  InvalidDeclaredValue
  UnknownZone
} derive(Debug, Eq, ToJson)

///|
pub struct ManifestIssue {
  tracking_no : String
  kind : ManifestIssueKind
  detail : String
} derive(Debug, Eq, ToJson)

///|
pub struct ManifestValidation {
  valid : Bool
  issues : Array[ManifestIssue]
  accepted : Int
} derive(Debug, Eq, ToJson)

///|
pub struct CustomsDocument {
  hs_code : String
  description : String
  declared_value : Money
  origin : String
  restricted : Bool
} derive(Debug, Eq, ToJson)

///|
pub(all) enum CustomsDecision {
  Clear
  Review
  Reject
} derive(Debug, Eq, ToJson)

///|
pub struct CustomsAssessment {
  decision : CustomsDecision
  duty : Money
  reasons : Array[String]
} derive(Debug, Eq, ToJson)

///|
pub struct AuditChain {
  events : Array[AuditEvent]
  digest : Int
} derive(Debug, Eq, ToJson)

///|
pub(all) enum PromiseStatus {
  OnTime
  AtRisk
  Breached
} derive(Debug, Eq, ToJson)

///|
pub struct ServicePromise {
  pickup_day : Int
  delivery_day : Int
  latest_day : Int
  status : PromiseStatus
} derive(Debug, Eq, ToJson)
