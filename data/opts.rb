module DataOpts

  def opts
  {
    input: {
      msg: "Placeholder",
      user_opt: :text,
      vertical: true
    },
    load: {
      user_opt: [],
      save: nil,
      vertical: false
    },
    message: {
      msg: "Placeholder",
      user_opt: [""]
    },
    play: {
      user_opt: [],
      players: nil,
      stats: nil,
      matrix: nil
    },
    save: {
        user_opt: ["y","n"],
        save: nil
        vertical: false,
      },
    title: {
      vertical: true
    },
    win: {
      state_file:"win",
      state_cmds: [:play_again, :save, :quit],
      vertical: true
    }
  }
  end

  def generate_opts state, **params
    opts_default = self.opts[state.to_sym]
    opts_hash = {
      state_file: params[:state_file] || opts_default[:state_file] || nil,
      args: params[:args] || opts_default[:args] || [],
      state_cmds: params[:state_cmds] || opts_default[:state_cmds] | [],
      screen_cmds: params[:screen_cmds] || opts_default[:screen_cmds] || [],
      vertical: params[:vertical] || opts_default[:vertical] || true
    }
    params.reduce opts_hash do | opts, (param, value) |
      opts[param] = value unless opts[param]
      opts
    end
  end

  def generate_args opts, **args
    opts_default = self.generate_opts opts[:state_file]
    args_default = opts_default[:args]
    args_return = {}
    args_default.each do |arg, val|
      return {missing_arg: arg} unless args[arg]
      args_return[arg] = args[arg] || val
    end
    args_return
  end


end
