require_relative "tic_tac_toe"

class Display < TicTacToe
  DISPLAY_CHOICES = {
    title: { choices: [:start, :load, :save, :quit], vertical: true },
    load: { choices: [:back, :quit], vertical: false },
    game: { choices: [:save, :quit], vertical: true },
    win: { choices: [:play_again, :save, :quit], vertical: true },
  }

  attr_accessor :active


  def return_user_input message, multi_entry, user_options
    super message, multi_entry, user_options
  end

  def get_opts_array opts_hash
    super opts_hash
  end

  def user_options command_arr
    super command_arr
  end

  def board
    super
  end

  def draw_board
    self.board.draw_board
  end

  def screen screen, args_arr, command_arr
    opts_hash = self.user_options command_arr
    opts_arr = self.get_opts_array opts_hash
    screen_str = self.method(screen)[args_arr]
    screen_str += self.opts_display opts_hash
    self.return_user_input screen_str, false, opts_arr
  end

  def opts_display opts_hash, vertical = false
    spacing = vertical ? "\n" : " | "
    return_string = "XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO\n"
    # concatenate all options in a given hash
    return_string += opts_hash.reduce return_string do |display, (option, input)|
      display += "#{option.to_s.split('_').map { |word| word.capitalize }.join " "}: #{input}#{spacing}"
      display
    end
    return_string += "XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO\n"
  end

  def title choices

    msg_title <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
                                        Tic Tac Toe!
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    Please press a key to choose your option:

    #{self.opts_display choices}

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

  def game players, stats
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

  def load data
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

  def win player, choices = [:play_again, :save, :quit]
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

#{(self.opts_display choices).replace('Start', 'Play Again')}

    STRING

  end
