module Error
    def error error_message
        "#{self.class.name}.#{__method__}  ERROR: #{error_message}"
    end
end
