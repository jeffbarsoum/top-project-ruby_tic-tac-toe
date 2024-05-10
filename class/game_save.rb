require_relative "../module/save"

class GameSave < Save

  attr_reader :game_data, :save_file = "game_save"

  def initialize save_directory, save_file = "game_save"
    super save_directory

    @save_file = save_file
    load_file = self.load_file save_file
    @game_data = [] unless load_file
    @game_data = self.load_file save_file

  end

  def create_save tic_tac_toe
    timestamp = Time.now
    save_hash = {
      timestamp: timestamp,
      name: "#{tic_tac_toe.players[0].name} vs. #{tic_tac_toe.players[1].name}",
      data: {
        tic_tac_toe: {
          obj: = tic_tac_toe,
          game_board: {
            obj: tic_tac_toe.game_board
            board_size: tic_tac_toe.game_board.board_size,
            game_matrix: tic_tac_toe.game_board.game_matrix,
            game_board: tic_tac_toe.game_board.game_board,
            sq_rows: tic_tac_toe.game_board.sq_rows,
            sq_cols: tic_tac_toe.game_board.sq_cols
          },
          players: tic_tac_toe.players,
          stats: tic_tac_toe.stats,
          display: tic_tac_toe.display
        }
      }
    }
    @game_data.push save_hash
  end




end
