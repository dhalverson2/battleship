# Battleship Project

## Game
  * Each player has two battleships. A cruiser and a sub
  * A cruiser is 3 cells long
  * A sub is 2 cells long
  * The board is a 4x4 layout
  * The cpu will randomly place their ships and then the user is prompted to input their ship coordinates.

## Implementation
  * We've implemented this in Ruby
  * We used the following classes to put this all together: Ship class, cell class, board class, player class, and a gameplay class.
  * We also added in some simple graphics that display in the terminal.
  * Game is started in the terminal with the following command: ```ruby battleship_runner.rb```

## Gameplay
  * User places ships
  * User picks a cell to fire_upon
  * If user enters invalid coordinates they will prompted to try again
  * If a user fires upon the same space they will lose that turn
  * This continues until a winner is decided.
  * A winner is decided when 1 player loses both of their ships.
  * The user will then have the option to play again or to quit.
