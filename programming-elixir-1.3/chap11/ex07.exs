defmodule Chap11 do

  def open_file(filename) do
    case File.open(filename) do
      {:ok, device} -> parse_file(device)
      {:error, _} -> IO.puts "There was an error!"
    end
  end

  def parse_file(device) do
    _header = IO.read(device, :line) |> String.split(",")
    IO.stream(device, :line)
    |> Stream.map(&String.strip/1)
    |> Enum.map(&(String.split(&1, ",")))
    |> process_data
  end

  def process_data(data) do
    Enum.map(data, fn([id, ship_to, net_amount]) -> [id: String.to_integer(id), ship_to: String.to_atom(String.trim_leading(ship_to, ":")), net_amount: String.to_float(net_amount)] end)
  end


  def orders_total(file, tax_rates) do
    orders = open_file(file)
    for order <- orders do
      total_amount = _calc_total(order[:net_amount], tax_rates[order[:ship_to]])
       order ++ [total_amount: total_amount]
    end
  end

  defp _calc_total(amount, nil), do: amount
  defp _calc_total(amount, rate), do: Float.round(amount * (1 + rate), 2)

end
