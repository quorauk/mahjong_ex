defmodule Player do
  defstruct tiles: [], discards: [], riichi: false

  def can_pon?(player, %{suit: suit, type: type}) do
    matcher = &match?(%Tile{suit: suit, type: type}, &1)

    discarded = Enum.any?(player.discards, matcher)
    has_two = Enum.filter(player.tiles, matcher)
    |> Enum.count == 2

    !discarded && has_two
  end

  def can_chii?(player, tile) do
    matcher = &match?(%Tile{suit: suit, type: type}, &1)

    discarded = Enum.any?(player.discards, matcher)

    Tile.forms_sequence?(tile, player.tiles) && !discarded
  end

  def can_kan?(player, tile) do
    player.tiles
    |> Enum.filter fn 

    false
  end
end
