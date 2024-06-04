require "error"

class Data
  include Error

  attr_reader :assets

  def import dir = "data", class_prefix = "Data"
    data_dir = "../#{dir}"
    assets = Dir data_dir
    assets.each do |asset|
      cls_name = self.get_class_name asset, class_prefix
      cls = Object.const_get cls_name
      instance = cls.new
      inst_assets = instance.instance_methods false
      inst_assets.each do |inst_asset|
        # create instance variables and getter functions
      end
      @assets.push instance
    end

  def get_class_name state_file, class_prefix = ""
      state_file_processed = state_file.replace ".rb", ""
      state_file_processed = state_file_processed.split "_"
      state_file_processed = state_file_processed.map! { |word| word.capitalize }
      state_file_processed = state_file_processed.join ""
      state_file_processed = "#{class_prefix}#{state_file_processed}"
      state_file_processed = state_file_processed.to_sym
  end


  def initialize
    @cmds = {
      o: :start,
      q: :quit,
      s: :save,
      l: :load,
      b: :back,
      r: :reset,
      a: :play_again
    }

    @opts = {
      title: { state_file:"title", state_cmds: [:start, :load, :save, :quit], vertical: true },
      load: { state_file:"load", state_cmds: [:back, :quit], vertical: false },
      game: { state_file:"game", state_cmds: [:save, :quit], vertical: true },
      win: { state_file:"win", state_cmds: [:play_again, :save, :quit], vertical: true },
    }

    @squares = {
      x: {
        place: [
          ['x', '', '', '', 'x'],
          ['', '', 'x', '', ''],
          ['x', '', '', '', 'x']
        ],
        win_horizontal: [
          ['x', '', '', '', 'x'],
          ['-', '-', '-', '-', '-'],
          ['x', '', '', '', 'x']
        ],
        win_vertical: [
          ['x', '', '|', '', 'x'],
          ['', '', '|', '', ''],
          ['x', '', '|', '', 'x']
        ],
        win_left_diagonal: [
          ['\\', '', '', '', 'x'],
          ['', '', '\\', '', ''],
          ['x', '', '', '', '\\']
        ],
        win_right_diagonal: [
          ['x', '', '', '', '/'],
          ['', '', '/', '', ''],
          ['/', '', '', '', 'x']
        ]
      }
      o:  {
        place: [
          ['', 'x', 'x', 'x', ''],
          ['x', '', '', '', 'x'],
          ['', 'x', 'x', 'x', '']
        ],
        horizontal: [
          ['', 'x', 'x', 'x', ''],
          ['-', '-', '-', '-', '-'],
          ['', 'x', 'x', 'x', '']
        ],
        vertical: [
          ['', 'x', '|', 'x', ''],
          ['x', '', '|', '', 'x'],
          ['', 'x', '|', 'x', '']
        ],
        left_diagonal: [
          ['\\', 'x', 'x', 'x', ''],
          ['x', '', '\\', '', 'x'],
          ['', 'x', 'x', 'x', '\\']
        ],
        right_diagonal: [
          ['', 'x', 'x', 'x', '/'],
          ['x', '', '/', '', 'x'],
          ['/', 'x', 'x', 'x', '']
        ]
      }
    }
  end

  def square player, piece_type = :place
    begin

      raise DataError unless self.squares.key? player
      raise DataError unless self.squares[player].key? piece_type

      self.squares[player][piece_type]
    rescue DataError
      msg_err = "piece must exist in squares hash!"
      puts self.error msg_err
    end
  end

  def nil_square coordinates
    begin
      row_coord = coordinates[1]
      col_coord = coordinates[0]

      is_valid_coord = "a".."z".to_a.include? col_coord && 1..9.to_a.include? row_coord

      raise DataError unless is_valid_coord

      [
        ['', '', '', '', ''],
        ['', col_coord '', row_coord ''],
        ['', '', '', '', '']
      ]
    end
    rescue DataError
      msg_err = "coordinates must be an alphabetic character followed by an integer!"
      puts self.error msg_err
    end
  end

  def cmd user_input
    return false unless user_input
    self.cmds[user_input]
  end

  def cmd_hash cmd_arr
    return self.cmds unless cmd_arr
    cmd_arr.reduce {} do | hash, cmd |
      hash[self.cmds.key cmd] = cmd
      hash
    end
  end

  def input_arr cmd_arr
    return self.cmds unless cmd_arr
    cmd_arr.reduce [] do | arr, cmd |
      arr.push self.cmds.key cmd
      arr
    end
  end

  def generate_opts state, **params
    opts_default = self.opts[state.to_sym]
    opts_hash = {
      state_file: opts_default[:state_file] || params[:state_file] || nil,
      args: opts_default[:args] || params[:args] || [],
      state_cmds: opts_default[:state_cmds] || params[:state_cmds] | [],
      screen_cmds: opts_default[:screen_cmds] || params[:screen_cmds] || [],
      vertical: opts_default[:vertical] || params[:vertical] || true
    }
    params.reduce opts_hash do | opts, (param, value) |
      opts[param] = value unless opts[param]
      opts
    end
  end

end
