import Config

IO.puts("environment: #{Mix.env()}")

import_config "#{Mix.env()}.exs"
