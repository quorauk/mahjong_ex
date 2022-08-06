defmodule Tile do
  defstruct suit: :man, type: :one, red: false

  def wind?(%Tile{suit: :wind}) do
    true
  end

  def wind?(_) do false end

  def forms_sequence(%Tile{suit: :winds}), do: false
  def forms_sequence(%Tile{suit: :dragons}), do: false

  def forms_sequence?(%Tile{suit: suit, type: type}, tiles) do
    of_suit = Enum.filter(tiles, fn %Tile{suit: match_suit} -> match_suit == suit end)

    above_1 = Enum.any?(of_suit, &match_num(type + 1, &1))
    above_2 = Enum.any?(of_suit, &match_num(type + 2, &1))
    below_1 = Enum.any?(of_suit, &match_num(type - 1, &1))
    below_2 = Enum.any?(of_suit, &match_num(type - 2, &1))

    valid_wait = (above_1 && above_2) || (below_1 && above_1) || (below_1 && below_2)

    Enum.count(of_suit) > 1 && valid_wait
  end

  defp match_num(num, tile) do
    tile.type == num
  end
end
