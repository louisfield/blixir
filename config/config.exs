import Config

config :blixir, Blixir.HTTP, Blixir.HTTP.Request

import_config("#{Mix.env()}.exs")
