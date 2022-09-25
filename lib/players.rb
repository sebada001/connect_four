class Players
  attr_reader :player_1, :player_2

  def initialize(name_1, name_2)
    @player_1 = {
      :name => name_1,
      :symb => "\u{1F602}"
    }
    @player_2 = {
      :name => name_2,
      :symb => "\u{1F636}"
    }
  end

end