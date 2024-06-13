class Cmds
  attr_reader :cmds

  def initialize
    @cmds = {
      back: {
        user_input: "b",
        text: "Back"
      }
      load: {
        user_input: "l",
        text: "Load"
      },
      play: {
        user_input: "p",
        text: "Play"
      },
      save: {
        user_input: "s",
        text: "Save"
      },
      quit: {
        user_input: "q",
        text: "Quit"
      }
    }
  end

  def cmd user_input
    return false unless user_input
    self.cmds.each { |cmd, hash| return cmd if hash[:user_input] == user_input }
  end

  def cmd_arr cmd_hash
    state_hash.reduce [] do |cmd_hash, (input, cmd)| 
      cmd_hash.push cmd
      cmd_hash
    end
  end

  def user_input_arr cmd_arr
    self.cmds.reduce [] do |input_arr, (cmd, cmd_hash)| 
      input_arr.push cmd_hash[:user_input] if cmd_arr.include? cmd
      input_arr
    end
  end

  def cmd_hash cmd_arr
    return self.cmds unless cmd_arr
    cmd_arr.reduce {} do | hash, cmd |
      hash[cmd] = self.cmds[:cmd]
      hash
    end
  end

end
