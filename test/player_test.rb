require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require 'pry'

class PlayerTest < Minitest::Test

  def test_it_exists
    human_player = Player.new("Human")
    cpu_player = Player.new("CPU")

    assert_instance_of Player, human_player
    assert_instance_of Player, cpu_player
  end

  def test_it_has_attributes
    human_player = Player.new("Human")
    cpu_player = Player.new("CPU")

    assert_equal "Human", human_player.type
    assert_equal "CPU", cpu_player.type
  end
end
