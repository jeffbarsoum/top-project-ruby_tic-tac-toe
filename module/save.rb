require 'yaml'

module Save

  attr_reader :save_directory, :data_list

  def initialize save_directory = "save_data"
    # making path relative to app's parent directory
    @save_directory = "../#{save_directory}"
    @data_list = self.get_save_data_list self.save_directory

  end

  def save_file data, key, overwrite? = false
    can_write_file = !self.is_data_exists || overwrite
    return false unless can_write_file
    File.open "#{self.save_directory}#{key}.yml", "w" { |file| file.write data.to_yaml }
    push self.data_list "#{key}.yml" unless self.is_data_exists
  end

  def load_file key
    load_file = "#{self.save_directory}#{key}.yml"
    return false unless self.is_data_exists? load_file
    YAML.load File.read load_file
  end

  def get_save_data_list
    Dir self.save_directory
  end

  def is_data_exists?
    self.data_list.include? "#{data}.yml"
  end

end
