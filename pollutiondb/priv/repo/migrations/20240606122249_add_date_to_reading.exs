defmodule MyApp.Repo.Migrations.AddDateToReadings do
  use Ecto.Migration

  def change do
    alter table(:readings) do
      add :date, :date
    end
  end
end