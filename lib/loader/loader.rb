require "lib/module/error"
require "lib/module/variablize"

class Loader
    include Error
    include Variablize

    def get_loader game
        raise NotImplementedError, self.error "Script not found" unless require_relative game
        cls_name = self.script_name, "Loader::"
        Object.const_get cls_name
    end

    def load_players
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def load_player
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def load_state_machine
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def load_stats
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def load_save
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def load_top_score
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def load_game
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

end
