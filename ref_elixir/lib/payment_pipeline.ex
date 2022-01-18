defmodule PaymentPipeline do
  use Opus.Pipeline

  link(ParseRecord)
  link(CreditCheck)
  link(FraudCheck)
  link(AMLCheck)
  link(PaymentPosting)
  link(PostProcessing)
end
