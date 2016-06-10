defmodule Spoticall.SmsView do
  use Spoticall.Web, :view

  def render("sms.json", %{sms: sms}) do
    sms
  end
end
