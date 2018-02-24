require './minesweeper_point'

class MinesweeperBoard

  def initialize(height: 10, width: 10, bomb_likelihood_percent: 10)
    @height = height
    @width = width
    @board = Array.new(width) { Array.new(height)}
    @height.times do |row|
      @width.times do |column|
        @board[row][column] = MinesweeperPoint.new(bomb_likelihood_percent: bomb_likelihood_percent)
      end
    end
  end

  def load_board(bomb_positions)
    # puts "bomb_positions: #{bomb_positions}"
    # puts "bomb_positions[0]: #{bomb_positions[0]}"
    @height = bomb_positions.length
    @width = bomb_positions[0].length
    @height.times do |row|
      @width.times do |column|
        bomb_likelihood_percent = 100.0 * bomb_positions[row][column]
        @board[row][column] = MinesweeperPoint.new(bomb_likelihood_percent: bomb_likelihood_percent)
      end
    end
  end

  def bomb_present?(row: 0, column: 0)
    if (row < 0) || (row >= @height) || (column < 0) || (column >= @width)
      raise "invalid point"
    end
    @board[row][column].bomb_present?
  end

  def uncover_point(row: 0, column: 0)
    if (row < 0) || (row >= @height) || (column < 0) || (column >= @width)
      raise "invalid point"
    end
    if @board[row][column].bomb_present?
      "bomb"
    else
      adjacent_bomb_count(row: row, column: column).to_s
    end
  end

  private

  def adjacent_bomb_count(row: 0, column: 0)
    if @board[row][column].adjacent_bomb_count.nil?
      adjacent_bomb_count = 0
      [-1, 0, 1].each do |row_offset|
        [-1, 0, 1].each do |column_offset|
          # puts "\trow_offset: #{row_offset}, column_offset: #{column_offset}"
          if (row_offset == 0) && (column_offset == 0)
            next
          end
          if (row + row_offset >= 0) && (row + row_offset < @height) && (column + column_offset >= 0) && (column + column_offset < @width)
            adjacent_bomb_present = @board[row + row_offset][column + column_offset].bomb_present?
            adjacent_bomb_count += 1 if @board[row + row_offset][column + column_offset].bomb_present?
          end
        end
      end
      @board[row][column].adjacent_bomb_count = adjacent_bomb_count
    else
      @board[row][column].adjacent_bomb_count
    end
  end
end
