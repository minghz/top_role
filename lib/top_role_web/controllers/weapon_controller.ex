defmodule TopRoleWeb.WeaponController do
  use TopRoleWeb, :controller

  alias TopRole.Resources
  alias TopRole.Resources.Weapon

  def index(conn, _params) do
    weapons = Resources.list_weapons()
    render(conn, "index.html", weapons: weapons)
  end

  def new(conn, _params) do
    changeset = Resources.change_weapon(%Weapon{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"weapon" => weapon_params}) do
    case Resources.create_weapon(weapon_params) do
      {:ok, weapon} ->
        conn
        |> put_flash(:info, "Weapon created successfully.")
        |> redirect(to: Routes.weapon_path(conn, :show, weapon))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    weapon = Resources.get_weapon!(id)
    render(conn, "show.html", weapon: weapon)
  end

  def edit(conn, %{"id" => id}) do
    weapon = Resources.get_weapon!(id)
    changeset = Resources.change_weapon(weapon)
    render(conn, "edit.html", weapon: weapon, changeset: changeset)
  end

  def update(conn, %{"id" => id, "weapon" => weapon_params}) do
    weapon = Resources.get_weapon!(id)

    case Resources.update_weapon(weapon, weapon_params) do
      {:ok, weapon} ->
        conn
        |> put_flash(:info, "Weapon updated successfully.")
        |> redirect(to: Routes.weapon_path(conn, :show, weapon))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", weapon: weapon, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    weapon = Resources.get_weapon!(id)
    {:ok, _weapon} = Resources.delete_weapon(weapon)

    conn
    |> put_flash(:info, "Weapon deleted successfully.")
    |> redirect(to: Routes.weapon_path(conn, :index))
  end
end
