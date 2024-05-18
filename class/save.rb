require_relative "../module/save"

class Save < Save

  attr_reader :data, :key,

  def initialize key = "save"
    super save_directory

    @key = key
    @data= self.load_file

  end

  def create_save tic_tac_toe
    timestamp = Time.now
    save_hash = {
      timestamp: timestamp,
      name: "#{tic_tac_toe.players[0].name} vs. #{tic_tac_toe.players[1].name}",
      data: {
        tic_tac_toe: {
          obj: = tic_tac_toe,
          board: {
            obj: tic_tac_toe.board
            board_size: tic_tac_toe.board.board_size,
            matrix: tic_tac_toe.board.matrix,
            board: tic_tac_toe.board.board,
            sq_rows: tic_tac_toe.board.sq_rows,
            sq_cols: tic_tac_toe.board.sq_cols
          },
          players: tic_tac_toe.players,
          stats: tic_tac_toe.stats,
          display: tic_tac_toe.display
        }
      }
    }
    @data.push save_hash
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
