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
test "route planner chooses the shortest feasible path" {
  let edges = [
    route_edge("A", "B", 10, 1, 1000, "local"),
    route_edge("B", "D", 10, 1, 1000, "regional"),
    route_edge("A", "C", 4, 3, 1000, "remote"),
    route_edge("C", "D", 4, 3, 1000, "remote"),
  ]
  let plan = plan_route(edges, "A", "D", 3, 500)
  debug_inspect(plan.nodes, content="[\"A\", \"C\", \"D\"]")
  inspect(plan.distance_km, content="8")
  inspect(plan.transit_days, content="6")
}

///|
test "invoice aging assigns an open balance to one bucket" {
  let invoice = invoice(
    "INV-AGE",
    [settlement_line("base", Money::yuan(100), true)],
    Money::yuan(6),
    Money::yuan(20),
  )
  let buckets = invoice_aging(invoice, 10, 25)
  inspect(buckets[2].amount.cents, content="8600")
}

///|
test "manifest validation reports duplicate and invalid records" {
  let items = [
    manifest_item(
      "T-1",
      "local",
      parcel_dim(width_cm=10, height_cm=10, depth_cm=10, weight_g=1000),
      Money::yuan(20),
    ),
    manifest_item(
      "T-1",
      "local",
      parcel_dim(width_cm=10, height_cm=10, depth_cm=10, weight_g=-1),
      Money::yuan(-1),
    ),
  ]
  let report = validate_manifest(items)
  assert_true(!report.valid)
  inspect(report.issues.length(), content="3")
}

///|
test "customs assessment distinguishes restricted goods" {
  let restricted = customs_document(
    "8517",
    "radio transmitter",
    Money::yuan(200),
    "CN",
    true,
  )
  let result = assess_customs(restricted, 600)
  debug_inspect(result.decision, content="Reject")
  inspect(result.duty.cents, content="1200")
}

///|
test "audit chain detects tampering" {
  let chain = audit_chain()
  let next = append_audit_event(
    chain,
    audit_event(1, "QUOTE_CREATED", "INV-1", Money::yuan(12)),
  )
  assert_true(audit_chain_is_consistent(next))
  assert_true(
    !audit_chain_is_consistent(audit_chain_with_digest(next, next.digest + 1)),
  )
}

///|
test "service promise classifies delivery risk" {
  let calendar = business_calendar([0, 6], [], 17)
  let promise = make_service_promise(calendar, 1, 16, 2, 1, 5)
  debug_inspect(promise.status, content="Breached")
  inspect(promise.latest_day, content="4")
}
