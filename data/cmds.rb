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
        state_file: "title",
        state_cmds: [:start, :load, :save, :quit],
        proc_opts: Proc.new { self.generate_opts "title" },
        proc_load: Proc.new { self.fsm.load_next_state "title", args, opts }
      },
      quit: {
        user_input: "q",
        state_file: "quit",
        state_cmds: [:yes, :no],
        proc_opts: Proc.new { self.generate_opts "quit" },
        proc_load: Proc.new { self.fsm.load_next_state "quit", args, opts }
      },
      save: {
        user_input: "s",
        state_file: "save",
        state_cmds: [:back, :quit],
        proc_opts: Proc.new { self.generate_opts "save" },
        proc_load: Proc.new { self.fsm.load_next_state "save", args, opts }
      },
      load: {
        user_input: "l",
        state_file: "load",
        state_cmds: [:back, :quit],
        proc_opts: Proc.new { self.generate_opts "load" },
        proc_load: Proc.new { self.fsm.load_next_state "load", args, opts }
      },
      back: {
        user_input: "b",
        proc_load: Proc.new {
          back_state = self.fsm.load_state 1
        }
      },
      reset: {
        user_input: "r",
        state_file: "title",
        state_cmds: [:start, :load, :save, :quit],
        proc_opts: Proc.new { self.generate_opts "title" },
        proc_load: Proc.new { self.fsm.load_next_state "title", args, opts }
      },
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
