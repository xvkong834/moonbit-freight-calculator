///|
pub fn business_calendar(
  weekend_days : Array[Int],
  holidays : Array[Int],
  cutoff_hour : Int,
) -> BusinessCalendar {
  { weekend_days, holidays, cutoff_hour: cutoff_hour.clamp(min=0, max=23) }
}

///|
pub fn is_business_day(calendar : BusinessCalendar, day : Int) -> Bool {
  !calendar.weekend_days.contains(day % 7) && !calendar.holidays.contains(day)
}

///|
pub fn add_business_days(
  calendar : BusinessCalendar,
  start_day : Int,
  amount : Int,
) -> Int {
  let mut day = start_day
  let mut remaining = amount.max(0)
  while remaining > 0 {
    day += 1
    if is_business_day(calendar, day) {
      remaining -= 1
    }
  }
  day
}

///|
pub fn service_deadline(
  calendar : BusinessCalendar,
  start_day : Int,
  start_hour : Int,
  transit_days : Int,
  buffer_days : Int,
) -> Int {
  let first_day = if start_hour >= calendar.cutoff_hour {
    add_business_days(calendar, start_day, 1)
  } else {
    start_day
  }
  add_business_days(calendar, first_day, transit_days + buffer_days)
}

///|
pub fn BusinessCalendar::is_valid(self : BusinessCalendar) -> Bool {
  self.cutoff_hour >= 0 && self.cutoff_hour <= 23
}

///|
pub fn BusinessCalendar::working_days_between(
  self : BusinessCalendar,
  start_day : Int,
  end_day : Int,
) -> Int {
  let mut total = 0
  for day in start_day..<=end_day {
    if is_business_day(self, day) {
      total += 1
    }
  }
  total
}

///|
pub fn BusinessCalendar::holiday_count(self : BusinessCalendar) -> Int {
  self.holidays.length()
}

///|
pub fn BusinessCalendar::weekend_count(self : BusinessCalendar) -> Int {
  self.weekend_days.length()
}
