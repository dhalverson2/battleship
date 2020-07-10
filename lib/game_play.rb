require './lib/board'
class GamePlay

  def initialize
    @human_player = Player.new("Human")
    @cpu_player = Player.new("CPU")
  end

  def welcome_message
    p "Welcome to BATTLESHIP"
    puts
    p "Enter p to play. Enter q to quit."
  end

  def user_input
    gets.chomp.downcase
  end

  # def cpu_ship_place
  # end

  def create_cpu_coordinate_array
    @cpu_player.board.cells.keys
  end

  def

  def end_game
  end
end
