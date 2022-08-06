defmodule PlayerTest do
  use ExUnit.Case
  doctest Player

  test "definition_of_this_test" do
    assert %Player{} == %Player{tiles: [], discards: [], riichi: false}
  end

  describe "can_chii?\2" do
    test "any player" do
      assert %Player{}
      |> Player.can_chii?(%Tile{}) == false
    end

    test "player with remaining tiles" do
      assert %Player{tiles: [%Tile{suit: :sou, type: 1}, %Tile{suit: :sou, type: 2}]}
      |> Player.can_chii?(%Tile{suit: :sou, type: 3}) == true
    end

    test "player who discarded that tile" do
      assert %Player{tiles: [%Tile{suit: :sou, type: 1}, %Tile{suit: :sou, type: 2}], discards: [%Tile{suit: :sou, type: 3}]}
      |> Player.can_chii?(%Tile{suit: :sou, type: 3}) == false
    end

    test "player who discarded the other tile" do
      assert %Player{tiles: [%Tile{suit: :sou, type: 2}, %Tile{suit: :sou, type: 3}], discards: [%Tile{suit: :sou, type: 4}]}
      |> Player.can_chii?(%Tile{suit: :sou, type: 1}) == false
    end
  end

  describe "can_kan?\2" do
    test "any player" do
      assert %Player{} |> Player.can_kan?(%Tile{}) == false
    end

    test "a player with three of that tile in hand" do
      tile = %Tile{suit: :dragons, type: :green}
      assert %Player{tiles: [tile, tile, tile]} |> Player.can_kan?(tile) == true
    end
  end

  describe "can_pon?\2" do
    test "player with two of the tile" do
      ponned = %Tile{suit: :sou, type: 5}
      assert %Player{tiles: [ponned, ponned]}
      |> Player.can_pon?(ponned) == true
    end

    test "player with two of different suit" do
      ponned = %Tile{suit: :sou, type: 5}
      assert %Player{tiles: [ponned, %Tile{suit: :pin, type: 5}]}
      |> Player.can_pon?(ponned) == true
    end

    test "player with one of the tile" do
      ponned = %Tile{suit: :sou, type: 5}
      assert %Player{tiles: [ponned]}
      |> Player.can_pon?(ponned) == false
    end

    test "player who discarded the tile" do
      ponned = %Tile{suit: :sou, type: 5}
      assert %Player{tiles: [ponned, ponned], discards: [ponned]}
      |> Player.can_pon?(ponned) == false
    end
  end
end
