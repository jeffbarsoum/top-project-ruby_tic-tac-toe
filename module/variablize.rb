module Variablize

  def script_name class_name
    class_name.reduce "" do | name, letter |
      name += letter if letter == letter.downcase
      name += "_#{letter.downcase}" if letter == letter.upcase
      name
    end
  end

  def class_name script_name, class_prefix = ""
    script_name_processed = script_name.replace ".rb", ""
    script_name_processed = script_name_processed.split "_"
    script_name_processed = script_name_processed.map! { |word| word.capitalize }
    script_name_processed = script_name_processed.join ""
    script_name_processed = "#{class_prefix}#{state_file_processed}"
    script_name_processed = script_name_processed.to_sym
  end

  def get_script_list dir
    Dir "../#{dir}/"
  end

end
