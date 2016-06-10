defmodule Spoticall.SmsControllerTest do
  use Spoticall.ConnCase

  alias Spoticall.Sms
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sms_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    sms = Repo.insert! %Sms{}
    conn = get conn, sms_path(conn, :show, sms)
    assert json_response(conn, 200)["data"] == %{"id" => sms.id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sms_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, sms_path(conn, :create), sms: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Sms, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sms_path(conn, :create), sms: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    sms = Repo.insert! %Sms{}
    conn = put conn, sms_path(conn, :update, sms), sms: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Sms, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sms = Repo.insert! %Sms{}
    conn = put conn, sms_path(conn, :update, sms), sms: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    sms = Repo.insert! %Sms{}
    conn = delete conn, sms_path(conn, :delete, sms)
    assert response(conn, 204)
    refute Repo.get(Sms, sms.id)
  end
end
