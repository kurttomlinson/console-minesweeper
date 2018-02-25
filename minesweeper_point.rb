class MinesweeperPoint
  attr_accessor :covered
  attr_accessor :bomb_present
  attr_accessor :adjacent_bomb_count

  @@rng = Random.new

  def initialize(bomb_likelihood_percent: 10)
    self.covered = true
    self.bomb_present = (@@rng.rand(100) < bomb_likelihood_percent)
  end
  def bomb_present?
    bomb_present
  end
  def covered?
    covered
  end
end
