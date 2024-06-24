# frozen_string_literal: true

class Loader
  attr_reader :load_script, :game_dir, :system_dir

  def initialize
    @system_dir = 'lib/game_system'
  end

  def load_game(game)
    raise NotImplementedError, error('Script not found') unless require_relative game

    @load_script = game
    @game_dir = "lib/game/#{load_script}"

    $LOAD_PATH.unshift system_dir unless $LOAD_PATH.include? system_dir

    $LOAD_PATH.each do |path|
      $LOAD_PATH.delete path if path.start_with? 'lib/game'
    end
    $LOAD_PATH.unshift game_dir

    cls_name = script_name, 'GameSystem::'
    Object.const_get(cls_name).new
  end
end
