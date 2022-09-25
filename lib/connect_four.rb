class Game 
  attr_reader :player_1, :player_2, :board

  require_relative 'Players'

  def initialize(player_1 = 'John', player_2 = 'Mon')
    players = Players.new(player_1, player_2)
    @player_1 = players.player_1
    @player_2 = players.player_2
    @board = Array.new(6) {Array.new(7, '  ')}
  end

  def display_board
    @board.each do |arr|
      p arr
    end
  end

  def make_move(column, pl)
    matching_index = false
    @board.each_with_index do |row, row_ind|
      if row[column] == '  '
        matching_index = row_ind
      end
    end
    return false if matching_index == false

    @board[matching_index][column] = pl[:symb]
  end

end

gamer = Game.new
gamer.make_move(0, gamer.player_1)
gamer.display_board