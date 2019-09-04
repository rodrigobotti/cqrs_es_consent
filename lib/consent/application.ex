defmodule Consent.Application do
  use Application

  def start(_type, args) do
    Consent.Supervisor.start_link(args)
  end

end
