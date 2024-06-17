require "lib/class/state"

class TicTacToe::State::Load < State

  attr_reader :cmd


  def opts param = nil
    super param
  end

  def opts=param, value
    super param, value
  end

  def run_cmd opts
    super opts
  end


  def initialize **opts
    super opts
  end

  def display data:, **args
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

  def back

  end

  def quit

  end

end
