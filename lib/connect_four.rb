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

    return horizontal_check if horizontal_check[0]

    diagonal_check
  end

  def game_over?
    !(check_winner[0] == false && @board.any? { |row| row.include?('  ') })
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

  def diagonal_check
    counter = 1
    player = nil
    6.times do |row|
      break unless counter < 4

      7.times do |col|
        checker_neg = lambda do |row_inner, col_inner, counter_inner = 1|
          counter = counter_inner
          return if counter_inner >= 4

          return unless move_valid(row_inner + 1, col_inner - 1)

          if (@board[row_inner][col_inner] == @board[row_inner + 1][col_inner - 1]) && @board[row_inner][col_inner] != '  '
            counter_inner += 1
            player = @board[row_inner][col_inner]
            checker_neg.call(row_inner + 1, col_inner - 1, counter_inner)
          end
        end
        checker_pos = lambda do |row_inner, col_inner, counter_inner = 1|
          counter = counter_inner
          return if counter_inner >= 4

          return unless move_valid(row_inner + 1, col_inner + 1)

          if (@board[row_inner][col_inner] == @board[row_inner + 1][col_inner + 1]) && @board[row_inner][col_inner] != '  '
            counter_inner += 1
            player = @board[row_inner][col_inner]
            checker_pos.call(row_inner + 1, col_inner + 1, counter_inner)
          end
        end
        checker_neg.call(row, col)
        break if counter >= 4

        checker_pos.call(row, col)
        break if counter >= 4
      end
    end
    counter >= 4 ? [true, player] : [false]
  end

  def move_valid(row, col)
    !@board[row].nil? && !@board[row][col].nil?
  end
end
