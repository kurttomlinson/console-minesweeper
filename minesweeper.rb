require './minesweeper_game'

def play
  puts "board width?"
  width = gets.to_i

  puts "board height?"
  height = gets.to_i

  puts "bomb likelihood percent? (0 to 100)"
  bomb_likelihood_percent = gets.to_i

  game = MinesweeperGame.new(height: height, width: width, bomb_likelihood_percent: bomb_likelihood_percent)

  while game.status == :in_progress
    puts game.board
    puts "x?"
    column = gets.to_i
    puts "y?"
    row = gets.to_i
    begin
      game.make_move(row: row, column: column)
    rescue MinesweeperBoard::InvalidPointError
      puts "invalid move location"
    end
  end

  puts game.board

  if game.status == :win
    puts "you won!"
  elsif game.status == :lose
    puts "you lost."
  end
end

play
