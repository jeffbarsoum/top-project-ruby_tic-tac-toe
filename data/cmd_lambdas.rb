module DataCmdLambdas

  def cmd_lambdas
  {
    start: Proc.new do |fsm, **opts|
      opts = self.generate_opts "title", opts
      fsm.load_next_state "title", [], opts[:state_cmds], opts[:screen_cmds]
    end,
    quit: Proc.new do |fsm, **opts|
      opts = self.generate_opts "quit", opts
      fsm.load_next_state "quit", [], [], []
    end,
    save: Proc.new do |fsm, **opts|
      opts = self.generate_opts "save", opts
      fsm.load_next_state "save", opts[:args], opts[:state_cmds], opts[:screen_cmds]
    end,
    load: Proc.new do |fsm, **opts|
      opts = self.generate_opts "load", opts
      fsm.load_next_state "load", opts[:args], opts[:state_cmds], opts[:screen_cmds]
    end,
    back: Proc.new do |fsm|
      fsm.load_state 1
    end,
    reset: Proc.new do |fsm, **opts|
      opts = self.generate_opts "title", opts
      fsm.load_next_state "title", [], opts[:state_cmds], opts[:screen_cmds]
    end,
    play_again: Proc.new do |fsm, **opts|
      opts = self.generate_opts "title", opts
      fsm.load_next_state "title", [], opts[:state_cmds], opts[:screen_cmds]
    end,
  }
  end

  def generate_opts state, **params
    opts_default = self.opts[state.to_sym]
    opts_hash = {
      state_file: opts_default[:state_file] || params[:state_file] || nil,
      args: opts_default[:args] || params[:args] || [],
      state_cmds: opts_default[:state_cmds] || params[:state_cmds] | [],
      screen_cmds: opts_default[:screen_cmds] || params[:screen_cmds] || [],
      vertical: opts_default[:vertical] || params[:vertical] || true
    }
    params.reduce opts_hash do | opts, (param, value) |
      opts[param] = value unless opts[param]
      opts
    end
  end

end
