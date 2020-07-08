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



end
