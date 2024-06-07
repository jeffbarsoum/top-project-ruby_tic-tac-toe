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
      start: {
        user_input: "o",
        next_state: "title",
        proc_opts: Proc.new { self.generate_opts "title" },
        proc_load: Proc.new { self.fsm.load_next_state "title", args, opts }
      },
      quit: {
        user_input: "q",
        next_state: "quit",
        proc_opts: Proc.new { self.generate_opts "quit" },
        proc_load: Proc.new { self.fsm.load_next_state "quit", args, opts }
      },
      save: {
        user_input: "s",
        next_state: "save",
        proc_opts: Proc.new { self.generate_opts "save" },
        proc_load: Proc.new { self.fsm.load_next_state "save", args, opts }
      },
      load: {
        user_input: "l",
        next_state: "load",
        proc_opts: Proc.new { self.generate_opts "load" },
        proc_load: Proc.new { self.fsm.load_next_state "load", args, opts }
      },
      back: {
        user_input: "l",
        next_state: "load",
        proc_opts: Proc.new { self.generate_opts "load" },
        proc_load: Proc.new { self.fsm.load_state "load", args, opts }
      },
      b: :back,
      r: :reset,
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
