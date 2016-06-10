defmodule Spoticall.SmsController do
  use Spoticall.Web, :controller

  alias Spoticall.Sms

  # plug :scrub_params, "song" when action in [:index]

  import ExTwilio.Message

  def index(conn, _params) do
    song = Map.get(conn.body_params, "Body")
    from = Map.get(conn.body_params, "From")
    to = Map.get(conn.body_params, "To")

    # ExTwilio.Message.create([from: to, to: from, body: "You sent #{song}"])
    IO.puts("You sent #{song}")
    Task.start_link(Spoticall.Spotify.search(song, %{from: from, to: to}))
    conn
    |> send_resp(200, "")
  end
end
