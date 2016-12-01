defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) when nucleotide > 0 do
    validate_strand!(strand)
    if (is_nucleotide?(nucleotide)) do
      _count(strand, nucleotide)
    else
      raise ArgumentError
    end
  end
  defp _count(strand, nucleotide) do
    Enum.filter(strand, &(&1 == nucleotide)) |>
      Enum.count
  end

  defp is_nucleotide?(test) do
    Enum.any?(@nucleotides, &(&1 == test))
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    validate_strand!(strand)
    @nucleotides |>
      Enum.reduce(%{}, &Map.put(&2, &1, count(strand, &1)))
    # reduce: (enum, accumulator, fn)
    # in the above scenario the enum is passed via |> (so its omitted as first parameter)
    # the %{} map acts as the accumulator
    # Map.put accepts (map, key, value)
    # since reduce's fn accepts parameters: (element, accumulator)
    # the accumulator is the original %{} so it needed to be passed to Map.put
    # out of order (i.e. Map.put(&2, &1)):
    # &2 = %{}
    # &1 = [individual nucleotide]
  end
  defp validate_strand!(strand) do
    if !(strand |> Enum.all?(&is_nucleotide?(&1))), do: raise ArgumentError
  end
end