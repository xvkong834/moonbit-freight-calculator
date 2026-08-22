///|
test "tariff decisions prefer applicable highest priority" {
  let candidates = [
    tariff_candidate("fallback", 1, 0, 99, [], Money::yuan(10)),
    tariff_candidate("heavy", 5, 0, 99, [WeightAtLeast(5000)], Money::yuan(30)),
  ]
  let result = choose_tariff(
    candidates,
    parcel_dim(width_cm=10, height_cm=10, depth_cm=10, weight_g=6000),
    "local",
    Money::zero(),
    10,
  )
  inspect(result.selected, content="heavy")
}

///|
test "configuration validation reports severity counts" {
  let summary = validate_configuration(["", "zone=local", "zone=local"])
  inspect(summary.errors, content="1")
  inspect(summary.warnings, content="1")
}

///|
test "invoice payment allocation has explicit balance state" {
  let invoice = invoice(
    "INV-1",
    [settlement_line("base", Money::yuan(100), true)],
    Money::yuan(6),
    Money::yuan(50),
  )
  debug_inspect(invoice_balance(invoice).0, content="PartiallyPaid")
  inspect(invoice_outstanding(invoice).cents, content="5600")
}

///|
test "business day deadline skips holidays and weekends" {
  let calendar = business_calendar([0, 6], [3], 17)
  inspect(add_business_days(calendar, 1, 2), content="4")
  inspect(service_deadline(calendar, 1, 16, 2, 2), content="8")
}

///|
test "customs summary adds duty and insurance" {
  let summary = calculate_customs([
    customs_line("A", Money::yuan(100), 500, 100),
    customs_line("B", Money::yuan(50), 1000, 0),
  ])
  inspect(summary.duty.cents, content="1000")
  inspect(summary.insurance.cents, content="100")
  inspect(summary.total.cents, content="16100")
}

///|
test "manifest reconciliation classifies missing and unexpected lines" {
  let report = reconcile_lines(
    [
      settlement_line("base", Money::yuan(10), true),
      settlement_line("fuel", Money::yuan(2), true),
    ],
    [
      settlement_line("base", Money::yuan(10), true),
      settlement_line("remote", Money::yuan(3), true),
    ],
    Money::from_cents(1),
  )
  inspect(report.matched, content="1")
  inspect(report.exceptions, content="2")
}

///|
test "bulk jobs transition deterministically" {
  let job = bulk_job("B-1", 10)
  debug_inspect(job.state, content="Queued")
  debug_inspect(job_after_success(job, 4).state, content="Running")
  debug_inspect(
    job_after_success(job_after_success(job, 4), 6).state,
    content="Succeeded",
  )
}

///|
test "domain factories preserve operational records" {
  let window = service_window("priority", 1, 3, 17)
  let leg = route_leg("CN", "DE", "EU", 2, 200000)
  let event = audit_event(7, "RATE_APPLIED", "priority rule", Money::yuan(18))
  inspect(window.service, content="priority")
  inspect(leg.capacity_g, content="200000")
  inspect(event.code, content="RATE_APPLIED")
}

///|
test "policy analyzers are deterministic and executable" {
  let parcel = parcel_dim(width_cm=10, height_cm=12, depth_cm=8, weight_g=3200)
  let rule = standard_rule()
  let value = Money::yuan(100)
  let scores = [
    tariff_policy_score(parcel, rule, value),
    settlement_policy_score(parcel, rule, value),
    sla_policy_score(parcel, rule, value),
    routing_policy_score(parcel, rule, value),
    customs_policy_score(parcel, rule, value),
    reconcile_policy_score(parcel, rule, value),
    bulk_policy_score(parcel, rule, value),
    audit_policy_score(parcel, rule, value),
    report_policy_score(parcel, rule, value),
    service_policy_score(parcel, rule, value),
    pricing_policy_score(parcel, rule, value),
    operations_policy_score(parcel, rule, value),
  ]
  for score in scores {
    assert_true(score >= 0)
  }
  assert_eq(scores[0], tariff_policy_score(parcel, rule, value))
}
