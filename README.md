# console-minesweeper
A console version of Minesweeper written in Ruby

# How to play

Just run `ruby ./minesweeper.rb`.

# How to test

Run `rspec ./minesweeper_spec.rb`.

# Example game

This is what a game looks like in the console:

```
board width?
6
board height?
4
bomb likelihood percent? (0 to 100)
20
game.status: in_progress

    0 1 2 3 4 5
    - - - - - -
0 |
1 |
2 |
3 |
x?
0
y?
0

    0 1 2 3 4 5
    - - - - - -
0 | 0 0 0 0 1
1 | 0 0 0 0 1
2 | 2 2 1 0 1 1
3 |     1 0 0 0
x?
5
y?
0

    0 1 2 3 4 5
    - - - - - -
0 | 0 0 0 0 1 1
1 | 0 0 0 0 1 x
2 | 2 2 1 0 1 1
3 | x x 1 0 0 0
you won!
```