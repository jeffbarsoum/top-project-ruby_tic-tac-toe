require "error"

module Data
  include Error


  attr_reader :squares


  def initialize
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

  # if player is nil, piece should be a string of coordinates
  # otherwise, it's a symbol representing the placement type
  def square player, piece_type = :place
    cls_name = "Data"
    func_name = "squares"
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
    cls_name = "Data"
    func_name = "nil_square"
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
      puts self.error cls_name, func_name, msg_err
    end
  end



end
