require 'rspec'
require './minesweeper'


describe 'MinesweeperPoint#initialize' do
  it 'should have a bomb present if bomb_likelihood_percent is 100' do
    point = MinesweeperPoint.new(bomb_likelihood_percent: 100)
    expect(point.bomb_present).to be true
  end
  it 'should not have a bomb present if bomb_likelihood_percent is 0' do
    point = MinesweeperPoint.new(bomb_likelihood_percent: 0)
    expect(point.bomb_present).to be false
  end
  it 'should have a bomb present half of the time if bomb_likelihood_percent is 50' do
    bomb_count = 0
    experiment_count = 1000000
    experiment_count.times do
      point = MinesweeperPoint.new(bomb_likelihood_percent: 50)
      if point.bomb_present?
        bomb_count += 1
      end
    end
    bomb_percentage = 100.0 * bomb_count / experiment_count
    expect(bomb_percentage).to be > 49.5
    expect(bomb_percentage).to be < 50.5
  end
  it 'should create a covered point' do
    point = MinesweeperPoint.new()
    expect(point.covered).to be true
  end
end

describe 'MinesweeperBoard#initialize' do
  it 'should create a board with about 10 bombs when width=20, height=5 and bomb_likelihood_percent=10' do
    width = 20
    height = 5
    board = MinesweeperBoard.new(height: height, width: width, bomb_likelihood_percent: 10)

    bomb_count = 0
    width.times do |column|
      height.times do |row|
        bomb_count += 1 if board.bomb_present?(row: row, column: column)
      end
    end

    expect(bomb_count).to be > 5
    expect(bomb_count).to be < 15
  end
end