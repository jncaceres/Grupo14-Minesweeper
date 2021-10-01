# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/minesweeper_model'
require_relative '../lib/minesweeper_controller'
require 'test/unit'

class MinesweeperModelTest < Test::Unit::TestCase
  def test_number_assign
    model_one = MinesweeperModel.new
    assert_equal(0, model_one.number)
    model_one.init_board(1)
    assert_equal(7, model_one.number)
    model_two = MinesweeperModel.new
    model_two.init_board(2)
    assert_equal(15, model_two.number)
  end

  def test_board_len
    model_one = MinesweeperModel.new
    assert_equal(0, model_one.mines_board.length)
    model_one.init_board(1)
    assert_equal(8, model_one.mines_board.length)
    model_two = MinesweeperModel.new
    model_two.init_board(2)
    assert_equal(16, model_two.mines_board.length)
  end

  def test_amount_of_mines
    model_one = MinesweeperModel.new
    assert_equal(0, model_one.positions.length)
    model_one.init_board(1)
    assert_equal(10, model_one.positions.length)
    model_two = MinesweeperModel.new
    model_two.init_board(2)
    assert_equal(40, model_two.positions.length)
  end

  def test_lose
    srand(123)
    model = MinesweeperModel.new
    model.init_board(1)
    # se que en esta posición NO hay una mina
    model.change_status(0, 0)
    assert_false(model.lose)
    # se que en esta posición hay una mina
    model.change_status(1, 0)
    assert_true(model.lose)
  end

  def test_not_won
    srand(123)
    model = MinesweeperModel.new
    model.init_board(1)
    # se que en esta posición NO hay una mina
    model.change_status(0, 0)
    assert_false(model.won)
  end

  def won_situation(model, row, col)
    if model.mines_board[row][col].obtain_value != '*' &&
       !model.mines_board[row][col].status && !(row.zero? && col.zero?)
      model.change_status(row, col)
    end
  end

  def test_won
    srand(123)
    model = MinesweeperModel.new
    model.init_board(1)
    # recorro todas las posiciones sin minas menos la 0,0
    (0..model.number).step(1) do |row|
      (0..model.number).step(1) do |col|
        won_situation(model, row, col)
      end
    end
    # se que en esta posición NO hay una mina
    model.change_status(0, 0)
    assert_true(model.won)
  end
end
