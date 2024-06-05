module DataOpts

  def opts
  {
    title: { state_file:"title", state_cmds: [:start, :load, :save, :quit], vertical: true },
    load: { state_file:"load", state_cmds: [:back, :quit], vertical: false },
    game: { state_file:"game", state_cmds: [:save, :quit], vertical: true },
    win: { state_file:"win", state_cmds: [:play_again, :save, :quit], vertical: true },
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
