require_relative "tic_tac_toe"

class Display < TicTacToe
  def title choices
    msg_title <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
                                        Tic Tac Toe!
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    Please press a key to choose your option:

    Start: "#{choices[:start]}"
    Load Save: "#{choices[:load]}"
    Quit: "#{choices[:quit]}"

    STRING
    msg_title
  end

  def spacing
    msg_spacing <<-STRING

    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
    puts msg_spacing

  end

  def hud players, stats
    p1 = players[0]
    p2 = players[1]
    p1_score = stats[:score][p1.player.to_sym]
    p2_score = stats[:score][p2.player.to_sym]
    p1_turn = stats[:turn][p1.player.to_sym]
    p2_score = stats[:turn][p2.player.to_sym]
    rnd = stats[:round]

    msg_hud <<-STRING

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

  def saves data
    print_save_list = ""
    data.each_with_index do |save, i|
      str_time = save.timestamp.strftime("%d/%m/%Y, %I:%M %p")
      str_name = save.name
      p1_score = "#{save.players[0].name}: #{save.players[0].score}"
      p2_score = "#{save.players[1].name}: #{save.players[1].score}"

      print_save_list += "${i + 1}) #{str_time} - #{str_name}:\n   #{p1_score}\n   #{p2_score}\n\n"
    end

    msg_save <<-STRING

    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    Choose your save, input the number shown to play your save:
    ------------------------------------------------------------------------------------
    #{print_save_list}
    ------------------------------------------------------------------------------------
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING

    self.title
    msg_hud
  end

  def win player
    player_win_msg = "*** #{player.name} Wins!! Ballin... ***"
    player_win_msg += player_win_msg.length % 2 == 0 ? "" : " "
    spacing_length = ((38 - player_win_msg.length) / 2).to_i
    spacing = Array.new(spacing_length, " ").join
    player_name = "#spacing"
    #banner contains 2 rows and 38 characters each
    #art borrowed from the below websites:
    # https://www.angelfire.com/ca/mathcool/4july.html
    # http://www.ae.metu.edu.tr/~cengiz/airplane-ascii.html

    msg_win <<-STRING
                                   ______________________________________
                  , _.o..__  / \  /      *** BREAKING NEWS!!! ***        |
                  +********=++-'-- #{spacing}#{player_win_msg}#{spacing} |
                  ` o/            \______________________________________|



                  .''.
                  .''.      .        *''*    :_\/_:     .
                :_\/_:   _\(/_  .:.*_\/_*   : /\ :  .'.:.'.
              .''.: /\ :    /)\   ':'* /\ *  : '..'.  -=:o:=-
              :_\/_:'.:::.  | ' *''*    * '.\'/.'_\(/_ '.':'.'
              : /\ : :::::  =  *_\/_*     -= o =- /)\     '  *
              '..'  ':::' === * /\ *     .'/.\'.  ' ._____
                *        |   *..*         :       |.   |' .---"|
                  *      |     _           .--'|  ||   | _|    |
                  *      |  .-'|       __  |   |  |    ||      |
                .-----.   |  |' |  ||  |  | |   |  |    ||      |
              ___'       ' /"\ |  '-."".    '-'   '-.'    '`      |____
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                  ~-~-~-~-~-~-~-~-~-~      /|
                    )      ~-~-~-~-~-~-~-~      /|~       /_|\
                  _-H-__  -~-~-~-~-~-~         /_|\    -~======-~
              ~-\XXXXXXXXXX/~     ~-~-~-~     /__|_\ ~-~-~-~
              ~-~-~-~-~-~    ~-~~-~-~-~-~    ========  ~-~-~-~
                ~-~~-~-~-~-~-~-~-~-~-~-~-~ ~-~~-~-~-~-~
                                  ~-~~-~-~-~-~

XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

Thanks for playing! What would you like to do?

XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

Play Again: "#{choices[:start]}"
Save: "#{choices[:save]}"
Quit: "#{choices[:quit]}"

    STRING

  end

  def board board
    board.populate_squares
    board.reduce '' do |display, pixel_row|
      display += pixel_row.flatten + "\n"
      display
    end
  end
