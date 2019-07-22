defmodule TopRoleWeb.SheetController do
  use TopRoleWeb, :controller

  alias TopRole.Character
  alias TopRole.Character.Sheet

  def index(conn, _params) do
    character_sheets = Character.list_character_sheets()
    render(conn, "index.html", character_sheets: character_sheets)
  end

  def new(conn, _params) do
    changeset = Character.change_sheet(%Sheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sheet" => sheet_params}) do
    case Character.create_sheet(sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet created successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sheet = Character.get_sheet!(id)
    render(conn, "show.html", sheet: sheet)
  end

  def edit(conn, %{"id" => id}) do
    sheet = Character.get_sheet!(id)
    changeset = Character.change_sheet(sheet)
    render(conn, "edit.html", sheet: sheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sheet" => sheet_params}) do
    sheet = Character.get_sheet!(id)

    case Character.update_sheet(sheet, sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet updated successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sheet: sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sheet = Character.get_sheet!(id)
    {:ok, _sheet} = Character.delete_sheet(sheet)

    conn
    |> put_flash(:info, "Sheet deleted successfully.")
    |> redirect(to: Routes.sheet_path(conn, :index))
  end
end
