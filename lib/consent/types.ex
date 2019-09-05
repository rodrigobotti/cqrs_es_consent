defmodule Consent.Types do
  @type actor :: binary
  @type target :: binary

  @spec actors :: [actor()]
  def actors(), do: ["patient", "doctor", "nurse"]

  @spec targets :: [target()]
  def targets(), do: ["all", "exams", "cids", "consultations", "er_visits"]

end
