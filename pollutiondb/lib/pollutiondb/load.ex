defmodule Pollutiondb.Load do

  def readStations() do
  datalist =
    File.read!("C:\\Users\\chinc\\Downloads\\pollution_50k.csv\\AirlyData-ALL-50k.csv")
    |> String.split("\n")

  readings =
    datalist
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&parse_line/1)

  stations = readings |> Enum.uniq_by(& &1.location)

  stations
  |> Enum.map(fn station ->
    {lon, lat} = station.location
    full_name = "#{station.stationName} #{station.stationId}"
    Pollutiondb.Station.add(full_name, lon, lat)
  end)

  readings |> Enum.map(fn reading->
    full_name = "#{reading.stationName} #{reading.stationId}"
    {date, time} = reading.datetime
    Pollutiondb.Reading.add(full_name, date, time,
                                      reading.pollutionType, reading.pollutionLevel) end)

  end

  def parse_line(line) do
      [
        datetime_str,
        pollutionType_str,
        pollutionLevel_str,
        stationId_str,
        stationName_str,
        location_str
      ] = line |> String.split(";")

      %{
        :datetime =>
          {{datetime_str |> String.slice(0, 4) |> String.to_integer(),
          datetime_str |> String.slice(5, 2) |> String.to_integer(),
          datetime_str |> String.slice(8, 2) |> String.to_integer()},
          {datetime_str |> String.slice(11, 2) |> String.to_integer(),
            datetime_str |> String.slice(14, 2) |> String.to_integer(),
            datetime_str |> String.slice(17, 2) |> String.to_integer()}},
        :location =>
          location_str
          |> String.split(",")
          |> Enum.map(&String.to_float/1)
          |> List.to_tuple(),
        :stationId => stationId_str |> String.to_integer(),
        :stationName => stationName_str,
        :pollutionType => pollutionType_str,
        :pollutionLevel => pollutionLevel_str |> String.to_float()
      }
  end
end