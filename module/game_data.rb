require_relative "../class/tic_tac_toe"

module GameData < TicTacToe
  attr_reader :squares

  def game_error class_name, function_name, error_message
    super class_name, function_name, error_message
  end

  def parse_coordinates coordinates
    super coordinates
  end


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
  def squares piece, player = nil
    cls_name = "GameData"
    func_name = "squares"
    begin
      return self.nil_square piece unless player

      raise GamePieceError unless self.squares.key? piece
      self.squares[piece]
    rescue GamePieceError
      msg_err = "piece must exist in squares hash!"
      puts self.game_error cls_name, func_name, msg_err
    end
  end

  def nil_square coordinates
    cls_name = "GameData"
    func_name = "nil_square"
    begin
      is_valid_coord = self.parse_coordinates coordinates

      raise GamePieceError is_valid_coord

      [
        ['', '', '', '', ''],
        ['', col_coord '', row_coord ''],
        ['', '', '', '', '']
      ]
    end
    rescue GamePieceError
      msg_err = "coordinates must be an alphabetic character followed by an integer!"
      puts self.game_error cls_name, func_name, msg_err
    end
  end



end
