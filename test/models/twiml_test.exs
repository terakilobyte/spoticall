defmodule Spoticall.TwimlTest do
  use Spoticall.ModelCase

  alias Spoticall.Twiml

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Twiml.changeset(%Twiml{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Twiml.changeset(%Twiml{}, @invalid_attrs)
    refute changeset.valid?
  end
end
