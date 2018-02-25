require './minesweeper_board'
require 'pry'

class MinesweeperGame
  attr_accessor :board
  attr_accessor :status

  def initialize()
    @status = :in_progress
  end

  def play
    puts "board width?"
    @width = gets.to_i

    puts "board height?"
    @height = gets.to_i

    puts "bomb likelihood percent? (0 to 100)"
    @bomb_likelihood_percent = gets.to_i

    @board = MinesweeperBoard.new(height: @height, width: @width, bomb_likelihood_percent: @bomb_likelihood_percent)

    while @status == :in_progress
      puts @board
      puts "x?"
      column = gets.to_i
      puts "y?"
      row = gets.to_i
      make_move(row: row, column: column)
    end

    @board.points.flatten.each do |point|
      point.covered = false
    end
    puts @board

    if @status == :win
      puts "you won!"
    elsif @status == :lose
      puts "you lost."
    end
  end

  def make_move(row: 0, column: 0)
    if (row < 0) || (row >= @height) || (column < 0) || (column >= @width)
      raise "invalid move"
    end
    @board.uncover_point(row: row, column: column)
    if @board.bomb_present?(row: row, column: column)
      @status = :lose
    end
    if game_is_won?
      @status = :win
    end
  end

  private

  def game_is_won?
    @board.points.flatten.each do |point|
      if !point.bomb_present? && point.covered?
        return false
      end
    end
    return true
  end
end
