///|
pub enum DiagnosticSeverity {
  Info
  Warning
  Error
} derive(Debug, Eq, ToJson)

///|
pub struct ConfigDiagnostic {
  code : String
  severity : DiagnosticSeverity
  field : String
  message : String
} derive(Debug, Eq, ToJson)

///|
pub struct ValidationSummary {
  errors : Int
  warnings : Int
  infos : Int
  diagnostics : Array[ConfigDiagnostic]
} derive(Debug, Eq, ToJson)

///|
pub(all) enum TariffPredicate {
  WeightAtLeast(Int)
  WeightAtMost(Int)
  LongestSideAtMost(Int)
  ZoneIs(String)
  DeclaredValueAtLeast(Money)
} derive(Debug, Eq, ToJson)

///|
pub struct TariffCandidate {
  id : String
  priority : Int
  effective_from : Int
  effective_to : Int
  predicates : Array[TariffPredicate]
  charge : Money
} derive(Debug, Eq, ToJson)

///|
pub struct DecisionTrace {
  selected : String
  considered : Int
  rejected : Array[String]
  reasons : Array[String]
} derive(Debug, Eq, ToJson)

///|
pub struct SettlementLine {
  code : String
  amount : Money
  taxable : Bool
} derive(Debug, Eq, ToJson)

///|
pub(all) enum BalanceState {
  Unpaid
  PartiallyPaid
  Paid
  Overpaid
} derive(Debug, Eq, ToJson)

///|
pub struct Invoice {
  id : String
  lines : Array[SettlementLine]
  tax : Money
  paid : Money
} derive(Debug, Eq, ToJson)

///|
pub struct PaymentAllocation {
  payment_id : String
  invoice_id : String
  amount : Money
  remaining : Money
} derive(Debug, Eq, ToJson)

///|
pub(all) enum ReconciliationStatus {
  Matched
  Difference
  MissingExpected
  UnexpectedActual
} derive(Debug, Eq, ToJson)

///|
pub struct ReconciliationItem {
  code : String
  expected : Money
  actual : Money
  difference : Money
  status : ReconciliationStatus
} derive(Debug, Eq, ToJson)

///|
pub struct ReconciliationReport {
  items : Array[ReconciliationItem]
  matched : Int
  exceptions : Int
  net_difference : Money
} derive(Debug, Eq, ToJson)

///|
pub struct BusinessCalendar {
  weekend_days : Array[Int]
  holidays : Array[Int]
  cutoff_hour : Int
} derive(Debug, Eq, ToJson)

///|
pub struct ServiceWindow {
  service : String
  minimum_days : Int
  maximum_days : Int
  cutoff_hour : Int
} derive(Debug, Eq, ToJson)

///|
pub struct RouteLeg {
  origin : String
  destination : String
  zone : String
  days : Int
  capacity_g : Int
} derive(Debug, Eq, ToJson)

///|
pub struct CustomsLine {
  code : String
  declared_value : Money
  duty_bp : Int
  insurance_bp : Int
} derive(Debug, Eq, ToJson)

///|
pub struct CustomsSummary {
  declared_value : Money
  duty : Money
  insurance : Money
  total : Money
} derive(Debug, Eq, ToJson)

///|
pub(all) enum JobState {
  Queued
  Running
  Succeeded
  Failed
  Retrying
} derive(Debug, Eq, ToJson)

///|
pub struct BulkJob {
  id : String
  state : JobState
  item_count : Int
  completed : Int
  failed : Int
  attempts : Int
} derive(Debug, Eq, ToJson)

///|
pub struct AuditEvent {
  sequence : Int
  code : String
  detail : String
  amount : Money
} derive(Debug, Eq, ToJson)
