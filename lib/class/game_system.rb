# frozen_string_literal: true

class GameSystem
  def load_cmds
    raise NotImplementedError, error('Method not implemented, famo...')
  end

  def load_players
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
