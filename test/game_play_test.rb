require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game_play'
require 'pry'

class GamePlayTest < Minitest::Test

  def test_it_exists
    game_play = GamePlay.new

    assert_instance_of GamePlay, game_play
  end

  # def test_it_displays_welcome_message
  #   game_play = GamePlay.new
  #
  #   assert_output(/"Welcome to BATTLESHIP"
  #   "Enter p to play. Enter q to quit."/), game_play.welcome_message
  # end

  def test_it_can_create_cpu_coordinates
    game_play = GamePlay.new

    assert_equal Array, game_play.create_cpu_coordinate_array_cruiser.class
  end

  def test_it_can_create_valid_cpu_coordinate_array
    game_play = GamePlay.new

    expected = [["A1", "A2", "A3"], ["A1", "B1", "C1"], ["A2", "A3", "A4"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "B2", "B3"], ["B1", "C1", "D1"], ["B2", "B3", "B4"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"]]
    assert_equal expected, game_play.select_cpu_valid_coordinate_array_cruiser
  end

end
