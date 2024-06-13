module DataCmds

  def cmds
    {
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
    self.cmds[user_input]
  end

  def cmd_arr cmd_hash
    state_hash.reduce [] { |cmd_hash, (input, cmd)| cmd_hash.push cmd; cmd_hash }
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
