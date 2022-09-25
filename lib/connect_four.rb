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

  def check_winner
    return vertical_check if vertical_check[0]

    horizontal_check
  end

  private

  def horizontal_check
    counter = 1
    player = nil
    @board.each_with_index do |row, _row_ind|
      row.each_with_index do |_col, col_ind|
        break if counter >= 4

        if !row[col_ind + 1].nil? && (row[col_ind] == row[col_ind + 1]) && row[col_ind] != '  '
          counter += 1
          player = row[col_ind]
        else
          counter = 1
        end
      end
    end
    counter >= 4 ? [true, player] : [false]
  end

  def vertical_check
    counter = 1
    player = nil
    0..5.times do |i|
      @board.each_with_index do |row, r_ind|
        break if counter >= 4

        if !@board[r_ind + 1].nil? && (row[i] == @board[r_ind + 1][i]) && row[i] != '  '
          counter += 1
          player = row[i]
        else
          counter = 1
        end
      end
    end

    counter >= 4 ? [true, player] : [false]
  end
end

gamer = Game.new
gamer.make_move(0, gamer.player1)
gamer.display_board
