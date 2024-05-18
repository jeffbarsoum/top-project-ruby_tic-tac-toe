module Error
    def error class_name, function_name, error_message
        puts "#{class_name}.#{function_name}  ERROR: #{error_message}"
    end
end
