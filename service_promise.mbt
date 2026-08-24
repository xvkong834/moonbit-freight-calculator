///|
pub fn make_service_promise(
  calendar : BusinessCalendar,
  pickup_day : Int,
  pickup_hour : Int,
  transit_days : Int,
  buffer_days : Int,
  actual_delivery_day : Int,
) -> ServicePromise {
  let delivery_day = service_deadline(
    calendar, pickup_day, pickup_hour, transit_days, 0,
  )
  let latest_day = service_deadline(
    calendar,
    pickup_day,
    pickup_hour,
    transit_days,
    buffer_days.max(0),
  )
  let status = if actual_delivery_day <= delivery_day {
    OnTime
  } else if actual_delivery_day <= latest_day {
    AtRisk
  } else {
    Breached
  }
  { pickup_day, delivery_day, latest_day, status }
}

///|
pub fn ServicePromise::is_on_time(self : ServicePromise) -> Bool {
  self.status == OnTime
}

///|
pub fn ServicePromise::is_breached(self : ServicePromise) -> Bool {
  self.status == Breached
}

///|
pub fn ServicePromise::slack_days(
  self : ServicePromise,
  actual_day : Int,
) -> Int {
  self.latest_day - actual_day
}
