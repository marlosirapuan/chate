# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chate,
  ecto_repos: [Chate.Repo]

# Configures the endpoint
config :chate, ChateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Va$ilNfwfE30oBD/octDEkjy0YccHh4vkH4yBim6lv6fuZBgxBAxixPAGPqyDU/i6AV",
  render_errors: [view: ChateWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chate.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Chate.Coherence.User,
  repo: Chate.Repo,
  module: Chate,
  web_module: ChateWeb,
  router: ChateWeb.Router,
  messages_backend: ChateWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Chate!",
  email_from_email: "noreply@chate.hafuk.net",
  opts: [
    :authenticatable,
    :recoverable,
    :lockable,
    :trackable,
    :unlockable_with_token,
    :confirmable,
    :registerable,
    :rememberable
  ]

config :coherence, ChateWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: System.get_env("SENDGRID_API")

# %% End Coherence Configuration %%
