defmodule Pollutiondb.Reading do
  use Ecto.Schema
  import Ecto.Query

  schema "readings" do
    field :date, :date
    field :time, :time
    field :type, :string
    field :value, :float
    belongs_to :station, Pollutiondb.Station
  end

  def load_sample_data() do
    %Pollutiondb.Reading{station_id: 561, date: ~D[2023-01-01], time: ~T[00:00:00], type: "PM10", value: 50.0} |> Pollutiondb.Repo.insert!()
    %Pollutiondb.Reading{station_id: 561, date: ~D[2023-01-02], time: ~T[00:00:00], type: "PM2.5", value: 30.0} |> Pollutiondb.Repo.insert!()
    %Pollutiondb.Reading{station_id: 562, date: ~D[2023-01-01], time: ~T[00:00:00], type: "PM10", value: 70.0} |> Pollutiondb.Repo.insert!()
    %Pollutiondb.Reading{station_id: 562, date: ~D[2023-01-02], time: ~T[00:00:00], type: "PM2.5", value: 40.0} |> Pollutiondb.Repo.insert!()
  end

  def add(station, date, time, type ,value) do
    %Pollutiondb.Reading{station_id: station, date: date, time: time, type: type, value: value}
  end

  def add_now(station, type, value) do
    date = Date.utc_today()
    time = Time.utc_now()
    add(station, date, time, type, value)
  end

  def findByDate(date) do
    Pollutiondb.Repo.all(
      from r in Pollutiondb.Reading,
      where: r.date == ^date
    )
  end
end
