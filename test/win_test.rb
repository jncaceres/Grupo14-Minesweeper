# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/minesweeper_model'
require 'test/unit'

class MinesweeperModelTest < Test::Unit::TestCase
  srand(123)
  def test_not_won
    model = MinesweeperModel.new
    model.init_board(1)
    # se que en esta posición NO hay una mina
    model.change_status(0, 0)
    assert_false(model.won)
  end

end