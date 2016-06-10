defmodule Spoticall.Router do
  use Spoticall.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Spoticall do
    pipe_through :api

    post "/sms", SmsController, :index

  end
end
