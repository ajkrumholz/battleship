
## Part 1 Demonstration of Functional Completeness

  - Run game, demonstrate game flow
  - Make sure to demonstrate edge cases in menu input
  - Demonstrate custom board size
  - Demonstrate addition of custom ships
  - Demonstrate edge cases during player ship placement

## Part 2 Technical Quality and Organization of Code

  - Additional classes
    - Game: handles flow of gameplay and most, though not all, input/output
            includes the menu system, game flow, and end game code
    - Player: handles player placement of ships
    - Computer: handles computer placement of ships

    Discuss limitations of this approach?

## Refactors

  - Personally, would like to refactor game.rb so that all player and computer behavior
    is located within the relevant class

## Test coverage

  - Discuss testing strategies and successes. Demonstrate implementation of SimpleCov
    with ./coverage/index.html reports.

## Pairing and version control

  - Hybrid of ping-pong and driver-navigator methods worked for us as we built the majority
    of our codebase
  - Once we both felt comfortable with our code, we chose to divide and conquer to refactor and finish
    implementing some pieces of iteration 4.
  - We both have a very good working knowledge of our program, and both made crucial contributions during
    testing and bug-fixing.
  - Number of pull requests, number of commits
  - Identify a Pull Request demonstrating good commenting/partner review workflow
