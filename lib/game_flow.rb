class GameFlow
  require_relative './connect_four'

  def initialize
    @player1 = nil
    @player2 = nil
    @game = nil
  end

  def game_loop
    greet_players
    play_game until @game.game_over?
    results = @game.check_winner
    @game.display_board
    if results[0]
      p "Game is over! #{results[1]} is the winner!"
    else
      p "Game is a over! It's a draw!"
    end
  end

  private

  def play_game
    @game.display_board
    p "It's #{@game.current_player[:name]}'s turn! Make a move from 0 to 6!"
    move = gets.chomp.to_i
    @game.make_move(move, @game.current_player)
    @game.switch_turns
  end

  def greet_players
    p "Connect 4 in a row to win! What's player 1 name?"
    @player1 = gets.chomp
    p "What's player 2 name?"
    @player2 = gets.chomp
    @game = Game.new(@player1, @player2)
  end
end

game = GameFlow.new
game.game_loop
