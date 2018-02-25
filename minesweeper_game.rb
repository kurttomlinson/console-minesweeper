require './minesweeper_board'

class MinesweeperGame
  attr_accessor :board
  attr_accessor :status

  def initialize(height: 10, width: 10, bomb_likelihood_percent: 10)
    @height = height
    @width = width
    @board = MinesweeperBoard.new(height: height, width: width, bomb_likelihood_percent: bomb_likelihood_percent)
    @game_status = :in_progress
  end

  def make_move(row: 0, column: 0)
    if (row < 0) || (row >= @height) || (column < 0) || (row >= @width)
      raise "invalid move"
    end
    @board.uncover_point(row: row, column: column)
    if @board.bomb_present?(row: row, column: column)
      @status = :lose
    end
  end

  def bomb_present?(row: 0, column: 0)
    @board[row][column].bomb_present?
  end
end