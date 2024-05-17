require_relative "/module/save"

def class TopScore < Save
  attr_reader :score_data, :key

  def initialize save_file = "top_score"
    @score_data = []
    super save_directory
  end

  def save_score tic_tac_toe
    timestamp = Time.now
    save_hash = {
      timestamp: timestamp,
      players: tic_tac_toe.players,
      stats: tic_tac_toe.stats
    }
    @score_data.push save_hash
  end

  def save_file
    super self.score_data, self.key, true
  end

  def load_file
    load_file = super self.key
    return @game_data = load_file || []
  end

end
