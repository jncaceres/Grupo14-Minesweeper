# frozen_string_literal: true

require_relative 'test_helper'
require 'test/unit'
require_relative '../lib/minesweeper_model'
require_relative '../lib/minesweeper_controller'
require_relative '../lib/minesweeper_view'

class MinesweeperControllerTest < Test::Unit::TestCase
  def test_initialize
    model = MinesweeperModel.new
    view = MinesweeperView.new
    model.add_observer(view)
    controller = MinesweeperController.new(model, view)
    assert_equal(controller.model, model)
    assert_equal(controller.view, view)
  end

  # Al tener una dificultad valida el tablero se crea
  def test_init_board
    model = MinesweeperModel.new
    view = MinesweeperView.new
    model.add_observer(view)
    controller = MinesweeperController.new(model, view)
    controller.view.difficult += 1
    controller.init_board(controller.view.difficult)
    assert_not_nil(model.mines_board)
  end

  def test_valid_move
    srand(123)
    model = MinesweeperModel.new
    view = MinesweeperView.new
    model.add_observer(view)
    model.init_board(1)
    controller = MinesweeperController.new(model, view)
    # El movimiento x=0 y=0 sera valido en cualquier caso pero para asegurarse se da una seed donde también es válido
    assert_true(controller.valid_move(0, 0))
    # El movimiento x=-1 y=-1 nunca será valido
    assert_false(controller.valid_move(-1, -1))
  end

  def win_buildup_aux(controller, row, col)
    if controller.model.mines_board[row][col].obtain_value != '*' &&
       !controller.model.mines_board[row][col].status && !(row.zero? && col.zero?)
      controller.model.change_status(row, col)
    end
  end

  def win_buildup(controller)
    (0..controller.model.number).step(1) do |row|
      (0..controller.model.number).step(1) do |col|
        win_buildup_aux(controller, row, col)
      end
    end
  end

  def test_move_win
    srand(123)
    model = MinesweeperModel.new
    view = MinesweeperView.new
    model.add_observer(view)
    model.init_board(1)
    controller = MinesweeperController.new(model, view)
    # Setearemos el juego para que termine al moverse a la posicion x= 0 e y=0
    win_buildup(controller)
    # Ingresamos el movimiento valido x=0 y=0
    controller.move(0, 0)
    assert_equal(1, controller.model.is_called_notify_all)
    assert_true(controller.model.won) # Si se gana es por que se movió
  end

  def test_move_lose
    srand(123)
    model = MinesweeperModel.new
    view = MinesweeperView.new
    model.add_observer(view)
    model.init_board(1)
    controller = MinesweeperController.new(model, view)
    # Ingresamos el movimiento valido x=1 y=0, donde hay una mina
    controller.move(1, 0)
    assert_equal(1, controller.model.is_called_notify_all)
    assert_true(controller.model.lose) # Si se gana es por que se movió
  end
end
