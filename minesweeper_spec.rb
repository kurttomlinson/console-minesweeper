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
  it 'should create a board with about 1000 bombs when width=200, height=50 and bomb_likelihood_percent=10' do
    width = 200
    height = 50
    board = MinesweeperBoard.new(height: height, width: width, bomb_likelihood_percent: 10)

    bomb_count = 0
    width.times do |column|
      height.times do |row|
        bomb_count += 1 if board.bomb_present?(row: row, column: column)
      end
    end

    expect(bomb_count).to be > 500
    expect(bomb_count).to be < 1500
  end
end

describe 'MinesweeperBoard#load_board' do
  it 'should create a board from a 2D array' do
    board = MinesweeperBoard.new()
    board.load_board([[1],[0],[0]])
    expect(board.bomb_present?(row: 0, column: 0)).to be true
    expect(board.bomb_present?(row: 1, column: 0)).to be false
    expect(board.bomb_present?(row: 2, column: 0)).to be false
  end
end

describe 'MinesweeperBoard#bomb_present?' do
  it 'should raise an error when checking an invalid point' do
    board = MinesweeperBoard.new()
    board.load_board([[1],[0],[0]])
    expect { board.bomb_present?(row: 0, column: 1)}.to raise_error("invalid point")
    expect { board.bomb_present?(row: 0, column: 2)}.to raise_error("invalid point")
  end
end

describe 'MinesweeperBoard#uncover_point' do
  it 'should return "bomb" when a bomb is uncovered' do
    board = MinesweeperBoard.new()
    board.load_board([[1],[0],[0]])
    expect(board.uncover_point(row: 0, column: 0)).to include('bomb')
  end
  it 'should return the number of adjacent bombs when uncovered' do
    board = MinesweeperBoard.new()
    board.load_board([[1],[0],[0]])
    expect(board.uncover_point(row: 1, column: 0)).to include('1')
    expect(board.uncover_point(row: 2, column: 0)).to include('0')
  end
  it 'should raise an error when an invalid point is uncovered' do
    board = MinesweeperBoard.new()
    board.load_board([[1],[0],[0]])
    expect { board.uncover_point(row: 0, column: 1) }.to raise_error("invalid point")
  end
end

describe 'MinesweeperGame#make_move' do
  it 'should raise an error on invalid moves' do
    game = MinesweeperGame.new
    expect { game.make_move(-1, -1) }.to raise_error("invalid move")
    expect { game.make_move(1000, 1000) }.to raise_error("invalid move")
  end
end
