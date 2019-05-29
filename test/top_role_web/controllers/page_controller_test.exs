defmodule TopRoleWeb.HomeControllerTest do
  use TopRoleWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "stay tuned for our launch"
  end
end
