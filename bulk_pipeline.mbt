///|
pub fn bulk_job(id : String, item_count : Int) -> BulkJob {
  {
    id,
    state: Queued,
    item_count: item_count.max(0),
    completed: 0,
    failed: 0,
    attempts: 0,
  }
}

///|
pub fn job_after_success(job : BulkJob, count : Int) -> BulkJob {
  let completed = (job.completed + count.max(0)).min(job.item_count)
  let state = if completed == job.item_count { Succeeded } else { Running }
  {
    id: job.id,
    state,
    item_count: job.item_count,
    completed,
    failed: job.failed,
    attempts: job.attempts + 1,
  }
}

///|
pub fn job_after_failure(
  job : BulkJob,
  count : Int,
  retryable : Bool,
) -> BulkJob {
  let failed = job.failed + count.max(0)
  let state = if retryable { Retrying } else { Failed }
  {
    id: job.id,
    state,
    item_count: job.item_count,
    completed: job.completed,
    failed,
    attempts: job.attempts + 1,
  }
}

///|
pub fn BulkJob::remaining(self : BulkJob) -> Int {
  (self.item_count - self.completed - self.failed).max(0)
}

///|
pub fn BulkJob::is_terminal(self : BulkJob) -> Bool {
  match self.state {
    Succeeded => true
    Failed => true
    _ => false
  }
}

///|
pub fn BulkJob::progress_bp(self : BulkJob) -> Int {
  if self.item_count <= 0 {
    10000
  } else {
    (self.completed + self.failed) * 10000 / self.item_count
  }
}
