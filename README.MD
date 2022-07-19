# AJ and Ben's Guide to BATTLESHIP 
## Getting started
Disclaimer: It is assumed that Ruby is already installed to run in Terminal

1. Navigate to the BATTLESHIP folder in Terminal.

1. To run theme music:
    * Install gem ruby2d
    * Navigate to battleship_runner.rb
    * Open battleship_runner.rb
    * Uncomment out menu_theme = Sound.new('menu_theme.mp3') and menu_theme.play (remove # from the beginning of the lines)

1. To start BATTLESHIP, yype 'ruby battleship_runner.rb' into Terminal and press return.

1. The menu will run, only type values with prompted.

## Game Setup

1. For prompt 'Enter p to play. Enter q to quit.' type 'p' to start a game, 'q' will exit to terminal.

1. Next, choose difficulty level. '1' for Easy or '2'for hard.
    * In Easy mode, every shot the computer takes is random.
    * In Hard mode, an 'Intelligent shot' will be taken by the computer when a hit on a player ship is made.

1. Select the board size:
    * Width can be set from 4 to 10 cells wide.
    * Height can be set from 4 to 10 cells wide.
    * Width and height do not have to match.

1. Choose to create more ships to play with. Entering 'y' will prompt the player to create new ships. Entering 'n' start the game with the default ships, a Cruiser that is 3 cells long and a Submarine that is 2 cells long.
    * When creating new ship, start by gving the ship a name.
    * Next, the player will set the length of the ship. *The ship(s) length(s) must not exceed cell dimensions of the board*

1. Placing ships
    * When prompted, enter the cell coordinates of the desired ship placement. This is done by entering all of the coordinates on the same line with a space between each input. *Example: 'Enter the squares for the Cruiser (3 spaces): **a1 a2 a3**'*

## Playing BATTLESHIP

1. At this point the playing boards will render. The computer board will load with a series of '.' to display coordinate points. the Player board will load showing an 'S' for where the ships are placed and '.' for cells where ships are not placed.

1. The Player will start the game by entering a coordinate to fire upon.

1. The Computer will takes a turn next.

1. A missed shot will generate a 'M' on the coordinate that was fired upon not holding a ship.

1. When a shot is fired and hits a ship, a 'H' is generated on the coordinate that was fired upon and has a ship.

1. The coordinates will render to 'X' when a ship is sunk.

1. The game ends when all of the ships on one side are sunk.

1. Once game is over, the Player will be prompted by 'Enter p to play. Enter q to quit.' Type 'p' to start a new game, 'q' will exit to terminal.
