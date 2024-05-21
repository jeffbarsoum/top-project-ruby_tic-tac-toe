require_relative "../module/save"

class GameSave < Save

  attr_reader :data, :key, :current_session

  def initialize key = "save"
    super save_directory

    @key = key
    @data= self.load_file

  end

  def save tic_tac_toe
    timestamp = Time.now
    save_hash = {
      timestamp: timestamp,
      name: "#{tic_tac_toe.players[0].name} vs. #{tic_tac_toe.players[1].name}",
      data: {
        tic_tac_toe: tic_tac_toe,
        board: tic_tac_toe.board,
        players: tic_tac_toe.players,
        stats: tic_tac_toe.stats,
        display: tic_tac_toe.display
      }
    }

    self.current_session = save_hash
  end

  def save_file
    super self.data, self.key, true
  end

  def load_file
    load_file = super self.key
    return load_file || []
  end

  def count
    self.data.length
  end

end
