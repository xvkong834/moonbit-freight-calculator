///|
pub struct Money {
  cents : Int
} derive(Debug, Eq, ToJson)

///|
pub struct ParcelDim {
  width_cm : Int
  height_cm : Int
  depth_cm : Int
  weight_g : Int
} derive(Debug, Eq, ToJson)

///|
pub struct ZoneRate {
  zone : String
  multiplier_bp : Int
  remote_fee : Money
} derive(Debug, Eq, ToJson)

///|
pub struct SurchargePolicy {
  overweight_limit_g : Int
  overweight_fee : Money
  oversize_limit_cm : Int
  oversize_fee : Money
  fuel_percent_bp : Int
  insurance_percent_bp : Int
} derive(Debug, Eq, ToJson)

///|
pub struct BillingRule {
  volumetric_divisor : Int
  first_weight_limit_g : Int
  first_weight_rate : Money
  additional_weight_unit_g : Int
  additional_weight_rate : Money
  min_charge : Money
  zones : Array[ZoneRate]
  surcharge : SurchargePolicy
} derive(Debug, Eq, ToJson)

///|
pub enum ChargeLine {
  Base(weight_g~ : Int, Money)
  Additional(units~ : Int, Money)
  Zone(zone~ : String, multiplier_bp~ : Int, Money)
  Remote(zone~ : String, Money)
  Overweight(limit_g~ : Int, Money)
  Oversize(limit_cm~ : Int, Money)
  Fuel(percent_bp~ : Int, Money)
  Insurance(percent_bp~ : Int, declared_value~ : Money, Money)
  Minimum(Money)
} derive(Debug, Eq, ToJson)

///|
pub struct Quote {
  billable_weight_g : Int
  actual_weight_g : Int
  volumetric_weight_g : Int
  subtotal : Money
  total : Money
  lines : Array[ChargeLine]
} derive(Debug, Eq, ToJson)

///|
pub struct ManifestItem {
  tracking_no : String
  zone : String
  parcel : ParcelDim
  declared_value : Money
} derive(Debug, Eq, ToJson)

///|
pub struct ManifestQuote {
  items : Array[Quote]
  total : Money
} derive(Debug, Eq, ToJson)

///|
pub(all) enum RoundingMode {
  HalfUp
  HalfDown
  Floor
  Ceiling
} derive(Debug, Eq, ToJson)

///|
pub struct ParcelProfile {
  longest_side_cm : Int
  shortest_side_cm : Int
  middle_side_cm : Int
  girth_cm : Int
  footprint_cm2 : Int
  surface_area_cm2 : Int
  density_g_per_l : Int
} derive(Debug, Eq, ToJson)

///|
pub struct DiscountRule {
  code : String
  percent_bp : Int
  cap : Money
} derive(Debug, Eq, ToJson)

///|
pub struct DiscountResult {
  original : Money
  discount : Money
  payable : Money
  applied : Array[String]
} derive(Debug, Eq, ToJson)

///|
pub struct TaxPolicy {
  rate_bp : Int
  threshold : Money
} derive(Debug, Eq, ToJson)

///|
pub struct TaxResult {
  taxable : Money
  exempt : Money
  tax : Money
  gross : Money
} derive(Debug, Eq, ToJson)

///|
pub struct Lane {
  origin : String
  destination : String
  zone : String
  transit_days : Int
} derive(Debug, Eq, ToJson)

///|
pub struct ManifestSummary {
  count : Int
  total_weight_g : Int
  average_weight_g : Int
  max_weight_g : Int
  min_weight_g : Int
  outlier_count : Int
} derive(Debug, Eq, ToJson)

///|
pub struct OperationalRate {
  code : String
  zone : String
  minimum_g : Int
  maximum_g : Int
  rate : Money
  multiplier_bp : Int
} derive(Debug, Eq, ToJson)
