///|
pub fn analyze_parcel(parcel : ParcelDim) -> ParcelProfile {
  let longest = parcel.longest_side_cm()
  let shortest = parcel.width_cm.min(parcel.height_cm).min(parcel.depth_cm)
  let middle = parcel.width_cm +
    parcel.height_cm +
    parcel.depth_cm -
    longest -
    shortest
  let girth = 2 * (middle + shortest)
  let footprint = middle * shortest
  let surface = 2 *
    (
      parcel.width_cm * parcel.height_cm +
      parcel.width_cm * parcel.depth_cm +
      parcel.height_cm * parcel.depth_cm
    )
  let volume = parcel.volume_cm3().max(1)
  {
    longest_side_cm: longest,
    shortest_side_cm: shortest,
    middle_side_cm: middle,
    girth_cm: girth,
    footprint_cm2: footprint,
    surface_area_cm2: surface,
    density_g_per_l: parcel.weight_g * 1000 / volume,
  }
}

///|
pub fn ParcelDim::normalized(self : ParcelDim) -> ParcelDim {
  {
    width_cm: self.width_cm.max(0),
    height_cm: self.height_cm.max(0),
    depth_cm: self.depth_cm.max(0),
    weight_g: self.weight_g.max(0),
  }
}

///|
pub fn ParcelDim::is_valid(self : ParcelDim) -> Bool {
  self.width_cm > 0 &&
  self.height_cm > 0 &&
  self.depth_cm > 0 &&
  self.weight_g > 0
}

///|
pub fn ParcelDim::chargeable_volume_l(self : ParcelDim) -> Int {
  (self.volume_cm3() + 999) / 1000
}

///|
pub fn ParcelDim::dimensional_density(self : ParcelDim) -> Int {
  let volume = self.volume_cm3()
  if volume <= 0 {
    0
  } else {
    self.weight_g * 1000 / volume
  }
}
