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
        proc: Proc.new do |fsm, players, **opts|
          opts = self.generate_opts "input", opts
          until Player.get_free_players.empty? do
            args[:msg] = "What would you like us to call you this round?"
            input_state = fsm.load_next_state "input", args, opts[:state_cmds], opts[:screen_cmds]
            player = Player.new input_state.user_input
            args[:msg] = "Hello, #{player.name}, you will be '#{player}''s"
            message_state = fsm.load_next_state "message", args, opts[:state_cmds], opts[:screen_cmds]
          end
          args[:msg] <<-STRING
          How big do you want the Tic Tac Toe Board to be?

            The default is 3, so 3 rows and 3 columns, and 3
            in a row wins

            You can go as high as 7:
          STRING
          input_state = fsm.load_next_state "input", args, opts[:state_cmds], opts[:screen_cmds]
        end,
      },
      q: :quit,
      s: :save,
      l: :load,
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
