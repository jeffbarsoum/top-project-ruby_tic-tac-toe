module DataCmds

  def cmds
    {
      o: :start,
      q: :quit,
      s: :save,
      l: :load,
      b: :back,
      r: :reset,
      a: :play_again
    }
  end

  def cmds
    {
      input: {
        "input"
      load: :l,
      start: :o,
      quit: :q,
      save: :s,
      back: :b,
      reset: :reset,
      a: :play_again
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
