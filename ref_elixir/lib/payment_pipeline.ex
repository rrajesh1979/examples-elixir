defmodule PaymentPipeline do
  use Opus.Pipeline

  link(ParseRecord)
  skip(:skip_invalid_record, if: &(&1.status === "CLOSED"))
  link(CreditCheck)
  link(FraudCheck)
  link(AMLCheck)
  link(PaymentPosting)
  link(PostProcessing)
end
