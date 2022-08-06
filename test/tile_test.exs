defmodule TileTest do
  use ExUnit.Case
  doctest Tile

  describe "wind?" do
    assert %Tile{suit: :wind} |> Tile.wind? == true
    assert %Tile{suit: :sou} |> Tile.wind? == false
  end

  describe "forms_sequence?" do
    test "empty" do
      assert Tile.forms_sequence?(%Tile{suit: :sou, type: 1}, []) == false
    end

    test "a sequence" do
      assert Tile.forms_sequence?(%Tile{suit: :sou, type: 1}, [%Tile{suit: :sou, type: 2}, %Tile{suit: :sou, type: 3}]) == true
    end

    test "a sequence of wrong suit" do
      assert Tile.forms_sequence?(%Tile{suit: :pin, type: 1}, [%Tile{suit: :sou, type: 2}, %Tile{suit: :sou, type: 3}]) == false
    end

    test "a non sequence of same suit" do
      assert Tile.forms_sequence?(%Tile{suit: :sou, type: 1}, [%Tile{suit: :sou, type: 3}, %Tile{suit: :sou, type: 4}]) == false
    end
  end
end
