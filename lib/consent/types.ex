defmodule Consent.Types do
  @type actor :: :patient | :doctor | :nurse
  @type target :: :all | :exams | :cids | :consultations | :er_visits
end
