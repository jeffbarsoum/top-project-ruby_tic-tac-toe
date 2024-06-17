class Loader

  attr_reader :load_script, :game_dir, :system_dir

  def initialize
    @system_dir = "lib/game_system"
  end

  def load_game game
    raise NotImplementedError, self.error "Script not found" unless require_relative game
    @load_script = game
    @game_dir = "lib/game/#{self.load_script}"

    $LOAD_PATH.unshift self.system_dir unless $LOAD_PATH.include? self.system_dir

    $LOAD_PATH.each |path| do
      $LOAD_PATH.delete path if path.start_with? "lib/game"
    end
    $LOAD_PATH.unshift self.game_dir

    cls_name = self.script_name, "GameSystem::"
    Object.const_get cls_name .new
  end

end
