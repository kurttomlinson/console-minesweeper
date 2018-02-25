require './minesweeper_board'

class MinesweeperGame
  attr_accessor :board
  attr_accessor :status

  def initialize(height: 10, width: 10, bomb_likelihood_percent: 10)
    @height = height
    @width = width
    @board = MinesweeperBoard.new(height: height, width: width, bomb_likelihood_percent: bomb_likelihood_percent)
    @status = :in_progress
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
