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

  def test_it_can_create_coordinates
    board = Board.new

    expected = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
    assert_equal expected.keys, board.create_coordinates.keys
    assert_equal true, board.create_coordinates.values.all? { |cell| cell.instance_of?(Cell)}
  end

  def test_it_contains_a_valid_coordinate
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")

    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_its_coordinates_count_is_equal_to_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)

    assert_equal true, board.valid_coordinate_count?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.valid_coordinate_count?(sub, ["B1", "B2"])

    assert_equal false, board.valid_coordinate_count?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_coordinate_count?(sub, ["B1", "B2", "B3"])
  end

  def test_it_contains_a_valid_set_of_ship_coordinates
    board = Board.new

    assert_equal true, board.valid_ship_coordinates?(["A1", "A2", "A3"])
    assert_equal true, board.valid_ship_coordinates?(["D3", "D4"])

    assert_equal false, board.valid_ship_coordinates?(["A3", "A4", "A5"])
    assert_equal false, board.valid_ship_coordinates?(["D4", "D5"])
  end

  def test_it_contains_a_valid_ship_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(sub, ["A2", "A3", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A4", "A5"])
    assert_equal false, board.valid_placement?(sub, ["A4", "A5"])

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.valid_placement?(sub, ["D1", "D2"])
  end

  def test_letters_ordinal_values
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)

    assert_equal [65, 66, 67], board.letter_ordinal(["A1", "B2", "C3"])
    assert_equal [65, 65, 65], board.letter_ordinal(["A1", "A2", "A3"])
  end

  def test_numbers_ordinal_values
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)

    assert_equal [1, 2, 3], board.number_ordinal(["A1", "B2", "C3"])
    assert_equal [1, 1, 1], board.number_ordinal(["A1", "B1", "C1"])
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
    assert_equal true, board.overlap?(["A1", "B1"])
    assert_equal false, board.overlap?(["D1", "D2"])
  end

  def test_it_can_render_board
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, board.render
    expected2 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected2, board.render(true)
  end

  def test_it_can_render_board_miss
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["B1"].fire_upon
    assert_equal "  1 2 3 4 \nA . . . . \nB M . . . \nC . . . . \nD . . . . \n", board.render
  end

  def test_it_can_render_board_hit
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon

    assert_equal "  1 2 3 4 \nA H H . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
  end

  def test_it_can_render_sunk
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon

    assert_equal "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n", board.render
  end
end
