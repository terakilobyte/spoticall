defmodule Spoticall.SmsController do
  use Spoticall.Web, :controller

  alias Spoticall.Sms


  import ExTwilio.Message

  def index(conn, _params) do
    song = Map.get(conn.body_params, "Body")
    from = Map.get(conn.body_params, "From")
    to = Map.get(conn.body_params, "To")

    Task.start_link(fn -> search_spotify(song, %{from: from, to: to}) end)
    conn
    |> send_resp(200, "")
  end

  defp search_spotify(song, twilio_data) do
    Spoticall.Spotify.search(song, twilio_data)
  end

end
