///|
pub fn parcel_dim(
  width_cm~ : Int,
  height_cm~ : Int,
  depth_cm~ : Int,
  weight_g~ : Int,
) -> ParcelDim {
  { width_cm, height_cm, depth_cm, weight_g }
}

///|
pub fn ParcelDim::volume_cm3(self : ParcelDim) -> Int {
  self.width_cm * self.height_cm * self.depth_cm
}

///|
pub fn ParcelDim::longest_side_cm(self : ParcelDim) -> Int {
  self.width_cm.max(self.height_cm).max(self.depth_cm)
}

///|
pub fn volumetric_weight_g(parcel : ParcelDim, divisor : Int) -> Int {
  div_ceil(parcel.volume_cm3() * 1000, divisor)
}

///|
pub fn billable_weight_g(parcel : ParcelDim, divisor : Int) -> Int {
  parcel.weight_g.max(volumetric_weight_g(parcel, divisor))
}
