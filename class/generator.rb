class Generator

    def generate_players
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def generate_player
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def generate_state_machine
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def generate_stats
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def generate_save
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def generate_top_score
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def generate_game
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

end