# frozen_string_literal: true

require './lib/connect_four'

describe Game do
  describe '#initialize' do
    context 'when no names are given' do
      subject(:game_test) { described_class.new }

      it 'player1 is John' do
        expect(game_test.player1[:name]).to eq('John')
      end
      it 'player2 is Mon' do
        expect(game_test.player2[:name]).to eq('Mon')
      end
    end

    context 'when names are given' do
      subject(:game_test) { described_class.new('Pepe', 'Pepa') }

      it 'player1 name matches the input' do
        expect(game_test.player1[:name]).to eq('Pepe')
      end
      it 'player2 name matches the input' do
        expect(game_test.player2[:name]).to eq('Pepa')
      end
    end

    context 'players have emoji symbols' do
      subject(:game_test) { described_class.new }

      it 'player1 is a laughing emoji' do
        expect(game_test.player1[:symb]).to eql("\u{1F602}")
      end
      it 'player2 is a muted emoji' do
        expect(game_test.player2[:symb]).to eq("\u{1F636}")
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
      dummy_player = { name: 'cleo', symb: ':)' }
      game_test.make_move(0, dummy_player)
      expect(game_test.board[-1][0]).to eql(':)')
    end

    it 'places one emoji on top of the other' do
      dummy_player2 = { name: 'nefer', symb: ':[' }
      2.times { game_test.make_move(0, dummy_player2) }
      expect(game_test.board[-2][0]).to eql(':[')
    end

    it 'returns false if overflow' do
      dummy_player2 = { name: 'nefer', symb: ':[' }
      6.times { game_test.make_move(0, dummy_player2) }
      expect(game_test.make_move(0, dummy_player2)).to eql(false)
    end
  end

  describe '#switch_turns' do
    subject(:game_test) { described_class.new('anon', 'benon') }

    it 'starts with player1' do
      expect(game_test.current_player[:name]).to eq('anon')
    end

    it 'switches turn' do
      game_test.switch_turns
      expect(game_test.current_player[:name]).to eq('benon')
    end

    it 'switches back to player1' do
      game_test.switch_turns
      game_test.switch_turns
      expect(game_test.current_player[:name]).to eq('anon')
    end
  end

  describe '#check_winner' do
    subject(:game_test) { described_class.new }
    my_player = { symb: "\u{1F602}", name: 'winner' }
    my_enemy = { symb: "\u{1F636}", name: 'loser' }

    it "doesn't win if just two placements" do
      game_test.make_move(0, my_player)
      game_test.make_move(1, my_player)
      expect(game_test.check_winner[0]).to eq(false)
    end

    it 'wins with 4 horizontal placements' do
      game_test.make_move(0, my_player)
      game_test.make_move(1, my_player)
      game_test.make_move(2, my_player)
      game_test.make_move(3, my_player)
      expect(game_test.check_winner[0]).to eq(true)
    end

    it 'returns the winners emoji' do
      game_test.make_move(0, my_player)
      game_test.make_move(1, my_player)
      game_test.make_move(2, my_player)
      game_test.make_move(3, my_player)
      expect(game_test.check_winner[1]).to eq("\u{1F602}")
    end

    it 'wins with 4 vertical placements' do
      4.times { game_test.make_move(0, my_player) }
      expect(game_test.check_winner[0]).to eq(true)
    end

    it 'wins diagonally' do
      game_test.make_move(0, my_player)
      game_test.make_move(1, my_enemy)
      game_test.make_move(1, my_player)
      game_test.make_move(2, my_player)
      game_test.make_move(2, my_enemy)
      game_test.make_move(2, my_player)
      game_test.make_move(3, my_player)
      game_test.make_move(3, my_enemy)
      game_test.make_move(3, my_player)
      game_test.make_move(3, my_player)
      game_test.display_board
      expect(game_test.check_winner[0]).to eq(true)
    end
  end
end
