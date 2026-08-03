///|
pub fn sample_manifest() -> Array[ManifestItem] {
  [
    {
      tracking_no: "MFC-1001",
      zone: "local",
      parcel: parcel_dim(width_cm=18, height_cm=12, depth_cm=8, weight_g=850),
      declared_value: Money::yuan(0),
    },
    {
      tracking_no: "MFC-1002",
      zone: "regional",
      parcel: parcel_dim(width_cm=42, height_cm=30, depth_cm=24, weight_g=2600),
      declared_value: Money::yuan(300),
    },
    {
      tracking_no: "MFC-1003",
      zone: "remote",
      parcel: parcel_dim(width_cm=130, height_cm=28, depth_cm=22, weight_g=6800),
      declared_value: Money::yuan(1200),
    },
  ]
}
