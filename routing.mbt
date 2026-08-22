///|
pub fn lane(
  origin~ : String,
  destination~ : String,
  zone~ : String,
  transit_days~ : Int,
) -> Lane {
  { origin, destination, zone, transit_days }
}

///|
pub fn resolve_lane(
  lanes : Array[Lane],
  origin : String,
  destination : String,
) -> Lane {
  for item in lanes {
    if item.origin == origin && item.destination == destination {
      break item
    }
  } nobreak {
    lane(origin~, destination~, zone="default", transit_days=0)
  }
}

///|
pub fn Lane::is_valid(self : Lane) -> Bool {
  self.origin.length() > 0 &&
  self.destination.length() > 0 &&
  self.zone.length() > 0 &&
  self.transit_days >= 0
}

///|
pub fn Lane::key(self : Lane) -> String {
  self.origin + "->" + self.destination + ":" + self.zone
}

///|
pub fn select_fastest_lane(
  lanes : Array[Lane],
  origin : String,
  destination : String,
) -> Lane {
  let mut selected = lane(origin~, destination~, zone="default", transit_days=0)
  let mut found = false
  for item in lanes {
    if item.origin == origin &&
      item.destination == destination &&
      (!found || item.transit_days < selected.transit_days) {
      selected = item
      found = true
    }
  }
  selected
}
