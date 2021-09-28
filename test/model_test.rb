# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/minesweeper_model'
require 'test/unit'

class MinesweeperModelTest < Test::Unit::TestCase
  srand(123)
  def test_number_assign
    model_1 = MinesweeperModel.new
    assert_equal(0, model_1.obtain_number)
    model_1.init_board(1)
    assert_equal(7, model_1.obtain_number)
    model_2 = MinesweeperModel.new
    model_2.init_board(2)
    assert_equal(15, model_2.obtain_number)
  end

  def test_board_len
    model_1 = MinesweeperModel.new
    assert_equal(0, model_1.obtain_mines_board.length())
    model_1.init_board(1)
    assert_equal(8, model_1.obtain_mines_board.length())
    model_2 = MinesweeperModel.new
    model_2.init_board(2)
    assert_equal(16, model_2.obtain_mines_board.length())
  end

end
