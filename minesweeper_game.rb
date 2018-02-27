require './minesweeper_board'
require 'pry'

class MinesweeperGame
  attr_accessor :board
  attr_accessor :status

  def initialize(height: 4, width: 6, bomb_likelihood_percent: 20)
    @status = :in_progress
    @board = MinesweeperBoard.new(height: height, width: width, bomb_likelihood_percent: bomb_likelihood_percent)
  end

  def make_move(row: 0, column: 0)
    @board.uncover_point(row: row, column: column)
    if (@board.bomb_present?(row: row, column: column)) && (@status == :in_progress)
      @status = :lose
      @board.uncover_all_points
    end
    if (game_is_won?) && (@status == :in_progress)
      @status = :win
      @board.uncover_all_points
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
