defmodule Spoticall.Spotify do

  @process Spoticall.Spotify.Query

  def start_link(proc, song, twilio_data, query_ref, owner) do
    proc.start_link(song, twilio_data, query_ref, owner)
  end

  def search(song, twilio_data) do
    spawn_search(song, twilio_data)
    |> await_results
  end

  def spawn_search(song, twilio_data) do
    query_ref = make_ref()
    opts = [@process, song, twilio_data, query_ref, self()]
    {:ok, pid} = Supervisor.start_child(Spoticall.Spotify.Supervisor, opts)
    monitor_ref = Process.monitor(pid)
    {pid, monitor_ref, query_ref}
  end

  defp await_results(process) do
    timeout = 9000
    timer = Process.send_after(self(), :timedout, timeout)
    results = await_result(process, "", :infinity)
    cleanup(timer)
    results
  end

  defp await_result(query_process, result, _timeout) do
    {pid, monitor_ref, query_ref} = query_process

    receive do
      {:results, ^query_ref, result, twilio_data} ->
        Process.demonitor(monitor_ref, [:flush])
        notify_success(result, twilio_data)
      {:DOWN, ^monitor_ref, :process, ^pid, _reason} ->
        # some kind of error logging
        IO.puts("oops")
      :timedout ->
        kill(pid, monitor_ref)
        IO.puts("oops")
        #some kind of error logging
    end
  end

  defp await_result(nil, _) do
    nil
  end


  defp notify_success(preview_url, %{from: from, to: to}) do
    IO.puts("#{preview_url}")
    # ExTwilio.Call.create([from: to, to: from, url: "http://tkb.ngrok.com/api/twiml-for?song=#{URI.encode_www_form(preview_url)}" ])
  end

  defp kill(pid, ref) do
    Process.demonitor(ref, [:flush])
    Process.exit(pid, :kill)
  end

  defp cleanup(timer) do
    :erlang.cancel_timer(timer)
    receive do
      :timedout -> :ok
    after
      0 -> :ok
    end
  end

end
