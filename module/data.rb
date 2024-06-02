require "error"

module Data
  include Error

  attr_reader :cmds, :squares


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


end
