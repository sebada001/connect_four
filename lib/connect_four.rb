# frozen_string_literal: true

# main game class
class Game
  attr_reader :player1, :player2, :board, :current_player

  require_relative 'Players'

  def initialize(player1 = 'John', player2 = 'Mon')
    players = Players.new(player1, player2)
    @player1 = players.player1
    @player2 = players.player2
    @board = Array.new(6) { Array.new(7, '  ') }
    @current_player = @player1
  end

  def display_board
    @board.each do |arr|
      p arr
    end
  end

  def make_move(column, player)
    matching_index = false
    @board.each_with_index do |row, row_ind|
      matching_index = row_ind if row[column] == '  '
    end
    return false if matching_index == false

    @board[matching_index][column] = player[:symb]
  end

  def switch_turns
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end

gamer = Game.new
gamer.make_move(0, gamer.player1)
gamer.display_board
