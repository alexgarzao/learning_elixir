defmodule Physics.Planet do

    defstruct [
        name: "Earth",
        radius_m: 6.371e6,
        mass_kg: 5.97e24,
    ]


end

#v = %Physics.Planet{} |> Physics.Planet.escape_velocity

defmodule Converter do
  def to_nearest_tenth(val) do
    Float.ceil(val, 1)
  end

  def to_km(val) do
    val / 1000
  end

  def to_meters(val) do
    val * 1000
  end

  def to_light_seconds({:miles, miles} = val) do
    (miles * 5.36819e-6) |> round_up
  end

  def to_light_seconds({:meters, meters} = val)  do
    (meters * 3.335638620368e-9) |> round_up
  end

  def to_light_seconds({:feet, feet} = val)  do
    (feet * 1.016702651488166404e-9) |> round_up
  end

  def to_light_seconds({:inches, inches} = val)  do
      (inches * 8.472522095734715723e-11) |> round_up
    end

    def round_up(val) when is_float(val), do: trunc(val)
  end

end

defmodule Physics.Rocketry do

    def escape_velocity(:earth) do
        %{mass: 5.972e24, radius: 6.371e6}
          |> escape_velocity
    end

    def escape_velocity(planet) when is_map(planet) do
        planet
          |> calculate_escape
          |> Converter.to_km
          |> Converter.to_nearest_tenth
    end

    defp calculate_escape(%{mass: mass, radius: radius}) do
        newtons_constant = 6.67e-11
        2 * newtons_constant * mass / radius
          |> :math.sqrt
    end

end
