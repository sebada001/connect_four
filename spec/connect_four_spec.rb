# frozen_string_literal: true
require './lib/connect_four.rb'

describe Game do
  describe '#initialize' do
    context 'when no names are given' do
      subject(:game_test) { described_class.new() }

      it 'player_1 is John' do
        expect(game_test.player_1[:name]).to eq('John')
      end
      it 'player_2 is Mon' do
        expect(game_test.player_2[:name]).to eq('Mon')
      end
    end

    context 'when names are given' do
      subject(:game_test) { described_class.new('Pepe', 'Pepa') }

      it 'player_1 name matches the input' do
        expect(game_test.player_1[:name]).to eq('Pepe')
      end
      it 'player_2 name matches the input' do
        expect(game_test.player_2[:name]).to eq('Pepa')
      end
    end

    context 'players have emoji symbols' do
      subject(:game_test) { described_class.new() }

      it 'player_1 is a laughing emoji' do
        expect(game_test.player_1[:symb]).to eql("\u{1F602}")
      end
      it 'player_2 is a muted emoji' do
        expect(game_test.player_2[:symb]).to eq("\u{1F636}")
      end
    end

    context 'board is created properly' do
      subject(:game_test) { described_class.new }

      it 'has a length of 7' do
        expect(game_test.board.length).to eq(6)
      end

      it 'array is a 2D array of 6 elements each' do
        numbers = (0..5)
        expect(game_test.board[rand(numbers)].length).to eq(7)
      end
    end


  end

  describe '#make_move' do 
    subject(:game_test) { described_class.new }

    it 'places an emoji in the correct spot' do
      dummy_player = { :name => 'cleo', :symb => ':)' }
      game_test.make_move(0, dummy_player)
      expect(game_test.board[-1][0]).to eql(':)')
    end

    it 'places one emoji on top of the other' do
      dummy_player_2 = { :name => 'nefer', :symb => ':[' }
      2.times { game_test.make_move(0, dummy_player_2) }
      expect(game_test.board[-2][0]).to eql(':[')
    end

    it 'returns false if overflow' do
      dummy_player_2 = { :name => 'nefer', :symb => ':[' }
      6.times { game_test.make_move(0, dummy_player_2) }
      game_test.display_board
      expect(game_test.make_move(0, dummy_player_2)).to eql(false)
    end
    
  end

end