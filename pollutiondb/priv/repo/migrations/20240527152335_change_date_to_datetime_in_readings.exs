defmodule Pollutiondb.Repo.Migrations.ChangeDateToDatetimeInReadings do
  use Ecto.Migration

  def change do
    alter table(:readings) do
      remove :date
      add :datetime, :naive_datetime
    end
  end
end