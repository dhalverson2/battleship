require './lib/board'
require 'pry'
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
    puts
    puts print_image("welcome_image.txt")
    welcome_message
    input = user_input
    if input == "P"
      cpu_place_ship
      initial_message
      player_place_cruiser
      display_board
      valid_sub_message
      player_place_sub
      turn
    elsif input == "Q"
      puts "Thanks for playing"
    else
      puts "INVALID input. Try again:"
      start
    end
  end

  def turn
    until game_over? do
      display_board
      player_shot
      cpu_shot
    end
    display_board
    if human_wins?
      puts
      puts "You won!"
    else
      puts
      puts "I won!"
    end
    puts print_image("game_over_image.txt")
    puts
    play_again
    start
  end

  def player_shot
    puts "Please enter a VALID coordinate for your shot:"
    player_shot = user_input
    until @cpu_player.board.valid_coordinate?(player_shot) do
      puts "That was INVALID. Try again:"
      player_shot = user_input
    end
    if @cpu_player.board.valid_coordinate?(player_shot)
      if @cpu_player.board.cells[player_shot].fired_upon?
        puts "Already fired upon this space. Lose a turn."
      else
        @cpu_player.board.cells[player_shot].fire_upon
        if @cpu_player.board.cells[player_shot].render == "X"
          puts "Your shot on #{player_shot} was a hit. #{@cpu_player.board.cells[player_shot].ship.name} was sunk!"
        elsif @cpu_player.board.cells[player_shot].render == "H"
          puts "Your shot on #{player_shot} was a hit."
        else
          puts "Your shot on #{player_shot} was a miss."
        end
      end
    end
  end

  def cpu_shot
    unfired_coordinates = @human_player.board.cells.values.select do |cell|
      !cell.fired_upon?
    end
    cpu_shot = unfired_coordinates.sample.coordinate
    @human_player.board.cells[cpu_shot].fire_upon
    if @human_player.board.cells[cpu_shot].render == "X"
      puts "My shot on #{cpu_shot} was a hit. #{@human_player.board.cells[cpu_shot].ship.name} was sunk!"
    elsif @human_player.board.cells[cpu_shot].render == "H"
      puts "My shot on #{cpu_shot} was a hit."
    else
      puts "My shot on #{cpu_shot} was a miss."
    end
  end

  def player_place_cruiser
    cruiser_coordinates = user_input.split(" ")
    until @human_player.board.valid_ship_coordinates?(cruiser_coordinates) && @human_player.board.valid_placement?(@human_cruiser, cruiser_coordinates) do
      puts "Those are INVALID coordinates. Please try again:"
      cruiser_coordinates = user_input.split(" ")
    end
    @human_player.board.place(@human_cruiser, cruiser_coordinates)
  end

  def player_place_sub
    sub_coordinates = user_input.split(" ")
    until @human_player.board.valid_ship_coordinates?(sub_coordinates) && @human_player.board.valid_placement?(@human_sub, sub_coordinates) do
      puts "Those are INVALID coordinates. Please try again:"
      sub_coordinates = user_input.split(" ")
    end
    @human_player.board.place(@human_sub, sub_coordinates)
  end

  def welcome_message
    puts
    puts "Welcome to BATTLESHIP"
    puts
    puts "Enter p to play. Enter q to quit."
    puts
  end

  def initial_message
    puts
    puts "I have laid out my ships on the grid."
    sleep 0.5
    puts "You now need to lay out your two ships."
    sleep 0.5
    puts "The Cruiser is three units long"
    sleep 0.5
    puts "and the Submarine is two units long."
    sleep 0.5
    puts "Example of valid cruiser coordinates is A1 A2 A3 or A3 B3 C3"
    sleep 0.5
    puts "Enter the squares for the cuiser (3 spaces):"
    puts
  end

  def display_board
    puts
    puts "=============COMPUTER BOARD============="
    puts @cpu_player.board.render
    puts "==============PLAYER BOARD=============="
    puts @human_player.board.render(true)
    puts
  end

  def valid_sub_message
    puts
    puts "Example of valid cruiser coordinates is C1 C2 or C4 D4"
    sleep 0.5
    puts "Enter the squares for the Submarine (2 spaces):"
    puts
  end

  def cpu_place_ship
    @cpu_player.board.place(@cpu_cruiser, random_placement_cruiser)
    @cpu_player.board.place(@cpu_sub, random_placement_sub)
  end

  def user_input
    gets.chomp.upcase
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
    human_wins? || cpu_wins?
  end

  def play_again
    @human_player = Player.new("Human")
    @cpu_player = Player.new("CPU")
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_sub = Ship.new("Submarine", 2)
    @human_cruiser = Ship.new("Cruiser", 3)
    @human_sub = Ship.new("Submarine", 2)
  end

  def print_image(image_file)
    File.read(image_file) do |line|
      puts line
    end
  end


end
