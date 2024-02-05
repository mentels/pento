defmodule Pento.Repo.Migrations.AddUsernameToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :citext, null: false
    end

    create_if_not_exists unique_index(:users, [:username])
  end
end
