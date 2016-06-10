defmodule Spoticall.SmsTest do
  use Spoticall.ModelCase

  alias Spoticall.Sms

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sms.changeset(%Sms{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sms.changeset(%Sms{}, @invalid_attrs)
    refute changeset.valid?
  end
end
