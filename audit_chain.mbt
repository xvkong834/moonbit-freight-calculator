///|
pub fn audit_chain() -> AuditChain {
  { events: [], digest: 0 }
}

///|
pub fn audit_chain_with_digest(chain : AuditChain, digest : Int) -> AuditChain {
  { events: chain.events, digest }
}

///|
fn audit_event_digest(event : AuditEvent) -> Int {
  event.sequence * 31 +
  event.code.length() * 17 +
  event.detail.length() * 13 +
  event.amount.cents
}

///|
fn audit_digest_step(previous : Int, event : AuditEvent) -> Int {
  previous * 31 + audit_event_digest(event)
}

///|
pub fn append_audit_event(chain : AuditChain, event : AuditEvent) -> AuditChain {
  let events = chain.events.copy()
  events.push(event)
  { events, digest: audit_digest_step(chain.digest, event) }
}

///|
pub fn audit_chain_is_consistent(chain : AuditChain) -> Bool {
  let mut digest = 0
  for event in chain.events {
    digest = audit_digest_step(digest, event)
  }
  digest == chain.digest
}

///|
pub fn AuditChain::length(self : AuditChain) -> Int {
  self.events.length()
}

///|
pub fn AuditChain::last_sequence(self : AuditChain) -> Int {
  match self.events.last() {
    None => 0
    Some(event) => event.sequence
  }
}

///|
pub fn AuditChain::is_monotonic(self : AuditChain) -> Bool {
  let mut previous = -1
  for event in self.events {
    if event.sequence <= previous {
      return false
    }
    previous = event.sequence
  }
  true
}
