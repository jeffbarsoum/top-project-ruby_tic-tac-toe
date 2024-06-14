require "game_state"

class Play < GameState

  def state_opts param = nil
    super param
  end

  def state_opts=param, value
    super param, value
  end

  def get_next_state
    super
  end

  def game_save
    super
  end


  def initialize matrix:, players:, stats:, **opts
    self.state_opts = :state_hash, self.cmds.cmd_hash [:save, :quit]
    self.state_opts = :state_cmds, self.cmds.user_input_arr [:save, :quit]
    self.state_opts = :screen_cmds, matrix.coordinates

    self.state_opts = :display, self.display matrix, players, stats
    self.state_opts = :vertical, true
    self.state_opts = :input?, true
    self.state_opts = :any_text?, false

    self.state_opts = :matrix, matrix
    self.state_opts = :players, players
    self.state_opts = :stats, stats

    super
  end

  def display matrix, players, stats
    p1 = players[0]
    p2 = players[1]
    p1_score = stats[:score][p1.player.to_sym]
    p2_score = stats[:score][p2.player.to_sym]
    p1_turn = stats[:turn][p1.player.to_sym]
    p2_score = stats[:turn][p2.player.to_sym]
    rnd = stats[:round]

    msg_hud <<-STRING
    #{self.draw_board matrix}
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    Round ##{rnd}, Turn ##{p1_turn}
    ------------------------------------------------------------------------------------
    #{p1.name}'s Turn:
    ------------------------------------------------------------------------------------
    #{p1.name} (#{p1})                                            #{p2.name} (#{p2})
    ----------------------                                        ----------------------
    score: #{p1_score}                                            score: #{p2_score}
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
    msg_hud
  end

  def draw_board matrix = self.state_opts :matrix
    top = "_"
    side = "|"
    # transpose the square arrays into one array row per pixel
    matrix.each_with_index do |matrix_row, matrix_row_id|
      row_arr = []
      matrix_row.each_with_index do |square, square_id|
        square.each_with_index do |square_row, square_row_id|
          row_arr.push = [] unless row_arr[square_row_id]
          row_arr[square_row_id].push [side, " "] if square_id == 0
          row_arr[square_row_id].push [" ", side, " "] if square_id.between() > 0 && square_id < square.length - 1
          row_arr[square_row_id].push square_row
          row_arr[square_row_id].push [" ", side] if square_id == square.length - 1
        end
      end
      # each horizontal border is composed of a "top" and "bottom" row
      border_top = row_arr[0].map { |px| px == side ? " " : top }
      border_bottom = row_arr[0].map { |px| px == side ? top : " " }
      # add top border for each row
      row_arr.unshift border_bottom
      row_arr.unshift border_top
      # for the last row, add a bottom row as well
      row_arr.push border_top if matrix_row_id = matrix.length - 1
      row_arr.push border_bottom if matrix_row_id = matrix.length - 1
      # finally, add each display_row to the array
      row_arr.each { | row | display_arr.push row.flatten }
    end
    # reduce array to a single string with /n separating rows of pixels
    display_arr.reduce "" do |display, display_row|
      display += display_row.join "" + "\n"
      display
    end
  end

end
