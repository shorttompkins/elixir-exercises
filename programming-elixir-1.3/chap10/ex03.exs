defmodule Chap10 do

  def orders_total(orders, tax_rates) do
    for order <- orders do
      total_amount = _calc_total(order[:net_amount], tax_rates[order[:ship_to]])
       order ++ [total_amount: total_amount]
    end
  end

  defp _calc_total(amount, nil), do: amount
  defp _calc_total(amount, rate), do: Float.round(amount * (1 + rate), 2)

end
