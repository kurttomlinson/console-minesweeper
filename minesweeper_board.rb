require './minesweeper_point'

class MinesweeperBoard

  def initialize(height: 10, width: 10, bomb_likelihood_percent: 10)
    @width = width
    @height = height
    @board = Array.new(width) { Array.new(height)}
    width.times do |column|
      height.times do |row|
        @board[row][column] = MinesweeperPoint.new(bomb_likelihood_percent)
      end
    end
  end

  def bomb_present?(row: 0, column: 0)
    @board[row][column].bomb_present?
  end
end
