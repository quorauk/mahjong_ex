defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  describe "setup" do
    test "setup()" do
      assert Board.setup.players == [
        %Player{},
        %Player{},
        %Player{},
        %Player{}
      ]
    end

    test "setup(players: 3)" do
      assert Board.setup(players: 3).players == [
        %Player{},
        %Player{},
        %Player{},
      ]
    end

    def match_count(tiles, matcher) do
      tiles
      |> Enum.filter(matcher)
      |> Enum.count
    end

    test 'setup expected number tiles' do
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :sou}, &1)) == 4 * 9
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :pin}, &1)) == 4 * 9
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :man}, &1)) == 4 * 9
      assert match_count(Board.setup.tiles, &match?(%Tile{red: true, type: 5}, &1)) == 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 1}, &1)) == 4 * 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 2}, &1)) == 4 * 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 3}, &1)) == 4 * 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 4}, &1)) == 4 * 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 5}, &1)) == 4 * 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 6}, &1)) == 4 * 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 7}, &1)) == 4 * 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 8}, &1)) == 4 * 3
      assert match_count(Board.setup.tiles, &match?(%Tile{type: 9}, &1)) == 4 * 3
    end

    test 'setup expected wind tiles' do
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :winds}, &1)) == 4 * 4
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :winds, type: :north}, &1)) == 4
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :winds, type: :south}, &1)) == 4
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :winds, type: :east}, &1)) == 4
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :winds, type: :west}, &1)) == 4
    end

    test 'setup expected dragon tiles' do
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :dragons}, &1)) == 3 * 4
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :dragons, type: :white}, &1)) == 4
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :dragons, type: :green}, &1)) == 4
      assert match_count(Board.setup.tiles, &match?(%Tile{suit: :dragons, type: :red}, &1)) == 4
    end
  end

  describe "deal\1" do
    test "deals tiles to all players" do
      thirteen_tiles = Enum.map(1..13, fn _ -> %Tile{} end)
      %Board{players: [player], tiles: []} = %Board{players: [%Player{}], tiles: thirteen_tiles} |> Board.deal
      assert Enum.count(player.tiles) == 13
    end

    test "stops when out of tiles" do
      %Board{players: [player], tiles: []} = %Board{players: [%Player{}], tiles: []} |> Board.deal
      assert Enum.count(player.tiles) == 0
    end
  end
end
