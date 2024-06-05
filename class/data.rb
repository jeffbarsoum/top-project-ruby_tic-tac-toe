class Data

  def initialize
    self.import
  end

  def import dir: "data", class_prefix: "Data"
    data_dir = "../#{dir}"
    assets = Dir data_dir
    assets.each do |asset|
      mod_name = self.get_class_name asset, class_prefix
      mod = Object.const_get cls_name
      include mod
    end
  end

  def get_class_name state_file, class_prefix = ""
      state_file_processed = state_file.replace ".rb", ""
      state_file_processed = state_file_processed.split "_"
      state_file_processed = state_file_processed.map! { |word| word.capitalize }
      state_file_processed = state_file_processed.join ""
      state_file_processed = "#{class_prefix}#{state_file_processed}"
      state_file_processed = state_file_processed.to_sym
  end

end
