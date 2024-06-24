# frozen_string_literal: true

require 'lib/class/players'

module TicTacToe
  class Players < Players
    attr_reader :array, :free_players, :chosen_players

    def initialize(player_ids = %i[x o])
      @free_players = player_ids
      @chosen_players = []
    end

    def choose_player
      player_index = free_players.length > 1 ? Random.rand.round : 0
      choose_player = @free_players.slice! player_index
      @chosen_players.push choose_player
      choose_player
    end

    def player_join=(p)
      @players.push p
    end

    def get_players(index = nil)
      return players[index] if index

      players
    end

    def get_current_player
      get_players 0
    end

    def get_next_player
      get_players 1
    end

    def change_player_turn
      players.push players.shift
    end
  end
end
