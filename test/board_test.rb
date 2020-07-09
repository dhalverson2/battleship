require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_it_can_have_cells
    board = Board.new

    assert_equal Hash, board.cells.class
    assert_equal 16, board.cells.count
    assert_equal Cell, board.cells["A1"].class
  end

  def test_it_contains_a_valid_coordinate
    board = Board.new

    assert_equal true, board.valid_coordinate("A1")
    assert_equal true, board.valid_coordinate("D4")

    assert_equal false, board.valid_coordinate("A5")
    assert_equal false, board.valid_coordinate("E1")
    assert_equal false, board.valid_coordinate("A22")
  end

  def test_it_contains_a_valid_ship_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(sub, ["A2", "A3", "A4"])

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.valid_placement?(sub, ["D1", "D2"])

  end

  def test_it_has_consecutive_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)

    assert_equal false, board.consecutive_coordinates?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.consecutive_coordinates?(sub, ["A1", "C1"])
    assert_equal false, board.consecutive_coordinates?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.consecutive_coordinates?(sub, ["C1", "B1"])

    assert_equal true, board.consecutive_coordinates?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.consecutive_coordinates?(sub, ["C1", "D1"])
  end

  def test_it_cannot_have_diagonal_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(sub, ["C2", "D3"])
  end

  def test_it_can_place_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_ships_cant_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)

    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal false, board.valid_placement?(sub, ["A1", "B1"])
  end
end
