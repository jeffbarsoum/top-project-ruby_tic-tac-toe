module GetUserInput
  # A function to pull input from the user
  # Can choose to print spacing, or get input, either or both
  def get_user_input print_spacing = false, get_input = true

    # an indicator to mark the user's input in the console
    print "--> "

    result = gets.chomp if get_input

  def print_spacing
        print "\n"
        print "########################################################################\n\n"
        print "\n"
  end

  def return_user_input message:, multi_entry: false, user_options: [':q'], **opts
    any_text? = opts[:any_text?] || false

    user_input = nil
    user_selection = nil
    dictionary = []

    # print the user message
    print message

    # ask for input and push it to the dictionary until user option is entered
    # 'q' is a default, it quits entry
    #  you can change 'q' to something else, but 'quit' is always the first option
    until user_options.include? user_selection do
      user_input = get_user_input
      user_selection = user_input if user_options.include? user_input
      dictionary.push format_val user_input unless user_selection
      break unless multi_entry
    end

    # just printing some spacing
    get_user_input true, false

    # create a hash for the return result
    result = { user_option: user_selection, dictionary: dictionary}

    # return results for processing
    return result[:dictionary].empty? ? result[:user_option] : result
  end
end
