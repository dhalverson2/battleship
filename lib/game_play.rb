require './lib/board'
class GamePlay

  def initialize
    @human_player = Player.new("Human")
    @cpu_player = Player.new("CPU")
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_sub = Ship.new("Submarine", 2)
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_sub = Ship.new("Submarine", 2)
  end

  def start
    welcome_message
    if user_input == "p"
      play_game
    elsif user_input == "q"
      "Thanks for playing"
    else
      welcome_message
    end 
  end

  def play_game
    until game_over? do
 # game loop
    end
  end






  def welcome_message
    p "Welcome to BATTLESHIP"
    puts
    p "Enter p to play. Enter q to quit."
  end

  def user_input
    gets.chomp.downcase
  end



  def create_cpu_coordinate_array_cruiser
    @cpu_player.board.cells.keys.permutation(3).to_a
  end

  def create_cpu_coordinate_array_sub
    @cpu_player.board.cells.keys.permutation(2).to_a
  end

  def select_cpu_valid_coordinate_array_cruiser
    create_cpu_coordinate_array_cruiser.select do |coordinate|
      @cpu_player.board.valid_placement?(@cpu_cruiser, coordinate)
    end
  end

  def select_cpu_valid_coordinate_array_sub
    create_cpu_coordinate_array_sub.select do |coordinate|
      @cpu_player.board.valid_placement?(@cpu_sub, coordinate)
    end
  end

  def random_placement_cruiser
    select_cpu_valid_coordinate_array_cruiser.sample
  end

  def random_placement_sub
    select_cpu_valid_coordinate_array_sub.sample
  end

  def human_wins?
    @cpu_cruiser.health == 0 && @cpu_sub.health == 0
  end

  def cpu_wins?
    @human_cruiser.health == 0 && @human_sub.health == 0
  end

  def game_over?
    human_wins || cpu_wins
  end
end
