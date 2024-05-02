module GameError

  def self.game_error class_name, function_name, error_message
    "#{class_name}.#{function_name}  ERROR: #{error_message}"
  return

end
