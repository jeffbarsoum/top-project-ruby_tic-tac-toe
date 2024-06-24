# frozen_string_literal: true

require 'lib/class/state'

module TicTacToe
  module State
    class Input < State
      def initialize message:, any_text:, cmds:, **opts
        self.opts = :hash, self.cmds.cmd_hash(cmds) || %i[back quit]
        self.opts = :cmds, self.cmds.user_input_arr(cmds) || %i[back quit]

        self.opts = :display, display(message)
        self.opts = :vertical, false
        self.opts = :input?, true
        self.opts = :any_text?, any_text?

        super
      end

      def display(message)
        msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    Yerrrrrrrr, question, famo...
    ------------------------------------------------------------------------------------
    #{message}
    ------------------------------------------------------------------------------------
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

        STRING
      end
    end
  end
end
