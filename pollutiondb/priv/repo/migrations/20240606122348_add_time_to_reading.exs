defmodule MyApp.Repo.Migrations.AddDateToReadings do
  use Ecto.Migration

  def change do
    alter table(:readings) do
      add :time, :time
    end
  end
end