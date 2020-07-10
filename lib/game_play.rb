require './lib/board'
class GamePlay

  def initialize
    @human_player = Player.new("Human")
    @cpu_player = Player.new("CPU")
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_sub = Ship.new("Submarine", 2)
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

  def create_cpu_coordinate_array_cruiser
    @cpu_player.board.cells.keys.permutation(3).to_a
  end

  def select_cpu_valid_coordinate_array_cruiser
    create_cpu_coordinate_array_cruiser.select do |coordinate|
      @cpu_player.board.valid_placement?(@cpu_cruiser, coordinate)
    end
  end

  def end_game
  end
end
