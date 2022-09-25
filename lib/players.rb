# frozen_string_literal: true

# for creating players
class Players
  attr_reader :player1, :player2

  def initialize(name1, name2)
    @player1 = {
      name: name1,
      symb: "\u{1F602}"
    }
    @player2 = {
      name: name2,
      symb: "\u{1F636}"
    }
  end
end
