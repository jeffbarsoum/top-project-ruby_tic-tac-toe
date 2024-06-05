require "error"

class Data
  include Error

  attr_reader :assets

  def import dir = "data", class_prefix = "Data"
    data_dir = "../#{dir}"
    assets = Dir data_dir
    assets.each do |asset|
      cls_name = self.get_class_name asset, class_prefix
      cls = Object.const_get cls_name
      instance = cls.new
      inst_assets = instance.instance_methods false
      inst_assets.each do |inst_asset|
        # create instance variables and getter functions
      end
      @assets.push instance
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
