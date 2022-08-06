defmodule Board do
  defstruct players: [], tiles: []

  @dragons [:green, :red, :white]
  @suits [:man, :pin, :sou]
  @winds [:north, :south, :east, :west]

  def setup() do
    %Board{
      players: [%Player{}, %Player{}, %Player{}, %Player{}],
      tiles: setup_tiles() |> Enum.shuffle
    }
  end

  def setup(players: 3) do
    %Board{players: [%Player{}, %Player{}, %Player{}]}
  end

  def deal(board) do
    if should_deal(board) do
      board
      |> deal_once
      |> deal
    else
      board
    end
  end

  def trigger_dora(board) do
  end

  def setup_tiles do
    initial_numbers() ++ initial_winds() ++ initial_dragons()
  end

  defp should_deal(%Board{players: players, tiles: tiles}) do
    players_needs_tile(players) && Enum.count(tiles) > 0
  end

  defp players_needs_tile(players) do
    players
    |> Enum.any?(fn %Player{tiles: tiles} ->
      Enum.count(tiles) < 13
    end)
  end

  defp deal_once(%Board{players: players, tiles: tiles}) do
    dealing_index = players
    |> Enum.find_index(fn player -> Enum.count(player.tiles) < 13 end)

    {dealing, remaining} = List.pop_at(players, dealing_index)
    [to_deal | remaining_tiles] = tiles

    dealing = %Player{tiles: dealing.tiles ++ [to_deal], discards: dealing.discards}

    %Board{players: remaining ++ [dealing], tiles: remaining_tiles}
  end

  defp initial_winds do
    Enum.flat_map @winds, fn type ->
      Enum.map(1..4, fn num ->
        %Tile{suit: :winds, type: type}
      end)
    end
  end

  defp initial_dragons do
    Enum.flat_map @dragons, fn type ->
      Enum.map(1..4, fn _ ->
        %Tile{suit: :dragons, type: type}
      end)
    end
  end

  defp initial_numbers do
    Enum.flat_map(@suits, fn suit ->
      Enum.flat_map(1..9, fn type ->
        Enum.map(1..4, fn num ->
          red = type == 5 && num == 1
          %Tile{suit: suit, type: type, red: red}
        end)
      end)
    end)
  end
end
