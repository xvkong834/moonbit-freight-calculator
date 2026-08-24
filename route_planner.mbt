///|
pub fn route_edge(
  from : String,
  to : String,
  distance_km : Int,
  transit_days : Int,
  capacity_g : Int,
  zone : String,
) -> RouteEdge {
  {
    from,
    to,
    distance_km: distance_km.max(0),
    transit_days: transit_days.max(0),
    capacity_g: capacity_g.max(0),
    zone,
  }
}

///|
pub fn RouteEdge::is_valid(self : RouteEdge) -> Bool {
  self.from.length() > 0 &&
  self.to.length() > 0 &&
  self.from != self.to &&
  self.distance_km > 0 &&
  self.transit_days >= 0 &&
  self.capacity_g > 0 &&
  self.zone.length() > 0
}

///|
fn route_walk(
  edges : Array[RouteEdge],
  current : String,
  destination : String,
  max_hops : Int,
  capacity : Int,
  path : Array[String],
  distance : Int,
  days : Int,
  plans : Array[RoutePlan],
) -> Unit {
  if current == destination {
    plans.push({
      nodes: path,
      distance_km: distance,
      transit_days: days,
      capacity_g: capacity,
      feasible: true,
    })
  } else if path.length() - 1 < max_hops {
    for edge in edges {
      if edge.from == current &&
        edge.is_valid() &&
        edge.capacity_g >= capacity &&
        !path.contains(edge.to) {
        let next_path = path.copy()
        next_path.push(edge.to)
        route_walk(
          edges,
          edge.to,
          destination,
          max_hops,
          capacity.min(edge.capacity_g),
          next_path,
          distance + edge.distance_km,
          days + edge.transit_days,
          plans,
        )
      }
    }
  }
}

///|
fn route_better(candidate : RoutePlan, current : RoutePlan) -> Bool {
  if !current.feasible {
    true
  } else if candidate.distance_km != current.distance_km {
    candidate.distance_km < current.distance_km
  } else if candidate.transit_days != current.transit_days {
    candidate.transit_days < current.transit_days
  } else {
    candidate.nodes.length() < current.nodes.length()
  }
}

///|
pub fn plan_route(
  edges : Array[RouteEdge],
  origin : String,
  destination : String,
  max_hops : Int,
  capacity_g : Int,
) -> RoutePlan {
  if origin.length() == 0 ||
    destination.length() == 0 ||
    max_hops <= 0 ||
    capacity_g <= 0 {
    return {
      nodes: [],
      distance_km: 0,
      transit_days: 0,
      capacity_g: 0,
      feasible: false,
    }
  }
  let plans : Array[RoutePlan] = []
  route_walk(
    edges,
    origin,
    destination,
    max_hops,
    capacity_g,
    [origin],
    0,
    0,
    plans,
  )
  let mut best : RoutePlan = {
    nodes: [],
    distance_km: 0,
    transit_days: 0,
    capacity_g: 0,
    feasible: false,
  }
  for plan in plans {
    if route_better(plan, best) {
      best = plan
    }
  }
  best
}

///|
pub fn RoutePlan::is_feasible(self : RoutePlan) -> Bool {
  self.feasible && self.nodes.length() >= 2 && self.distance_km > 0
}

///|
pub fn RoutePlan::hop_count(self : RoutePlan) -> Int {
  (self.nodes.length() - 1).max(0)
}
