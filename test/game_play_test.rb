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


end
