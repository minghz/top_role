defmodule TopRoleWeb.GamePresence do
  use Phoenix.Presence,
    otp_app: :top_role,
    pubsub_server: TopRole.PubSub
end