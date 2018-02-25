require './minesweeper_point'

class MinesweeperBoard
  attr_accessor :points

  class InvalidPointError < RuntimeError
  end

  def initialize(height: 10, width: 10, bomb_likelihood_percent: 10)
    @height = height
    @width = width
    @points = Array.new(width) { Array.new(height)}
    @height.times do |row|
      @width.times do |column|
        @points[row][column] = MinesweeperPoint.new(bomb_likelihood_percent: bomb_likelihood_percent)
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
        @points[row][column] = MinesweeperPoint.new(bomb_likelihood_percent: bomb_likelihood_percent)
      end
    end
  end

  def bomb_present?(row: 0, column: 0)
    if (row < 0) || (row >= @height) || (column < 0) || (column >= @width)
      raise InvalidPointError.new
    end
    @points[row][column].bomb_present?
  end

  def uncover_point(row: 0, column: 0)
    if (row < 0) || (row >= @height) || (column < 0) || (column >= @width)
      raise InvalidPointError.new
    end
    if !@points[row][column].covered
      return
    end
    @points[row][column].covered = false
    if adjacent_bomb_count(row: row, column: column) == 0
      [-1, 0, 1].each do |row_offset|
        [-1, 0, 1].each do |column_offset|
          next_row = row + row_offset
          next_col = column + column_offset
          begin
            self.bomb_present?(row: next_row, column: next_col)
            unless self.bomb_present?(row: next_row, column: next_col)
              self.uncover_point(row: next_row, column: next_col)
            end
          rescue InvalidPointError
          end
        end
      end
    end
  end

  private

  def adjacent_bomb_count(row: 0, column: 0)
    if @points[row][column].adjacent_bomb_count.nil?
      adjacent_bomb_count = 0
      [-1, 0, 1].each do |row_offset|
        [-1, 0, 1].each do |column_offset|
          # puts "\trow_offset: #{row_offset}, column_offset: #{column_offset}"
          if (row_offset == 0) && (column_offset == 0)
            next
          end
          if (row + row_offset >= 0) && (row + row_offset < @height) && (column + column_offset >= 0) && (column + column_offset < @width)
            adjacent_bomb_present = @points[row + row_offset][column + column_offset].bomb_present?
            adjacent_bomb_count += 1 if @points[row + row_offset][column + column_offset].bomb_present?
          end
        end
      end
      @points[row][column].adjacent_bomb_count = adjacent_bomb_count
    else
      @points[row][column].adjacent_bomb_count
    end
  end
end
