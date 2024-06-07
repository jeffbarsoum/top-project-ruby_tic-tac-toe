module DataOpts

  def opts
  {
    input: {
      state_file:"input",
      state_cmds: [],
      args: {
        msg: "Placeholder",
        user_opt: :text,
      vertical: true
      }
    },
    load: {
      state_file:"load",
      state_cmds: [:back, :quit],
      args: {
        user_opt: [],
        save: nil,
      vertical: false
      }
    },
    message: {
      state_file:"message",
      state_cmds: [],
      args: {
        msg: "Placeholder",
        user_opt: [""]
      }
    },
    play: {
      state_file:"play",
      state_cmds: [:save, :quit],
      args: {
        user_opt: [],
        players: nil,
        stats: nil,
        matrix: nil
      }
    },
    save: {
      state_file:"save",
      state_cmds: [],
      screen_cmds: [],
      vertical: false,
      args: {
        user_opt: ["y","n"],
        save: nil
      }
    },
    title: {
      state_file:"title",
      state_cmds: [:start, :load, :save, :quit],
      args: {
      vertical: true
      }
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

end
