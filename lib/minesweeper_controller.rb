# frozen_string_literal: true

# Controlador del juego
class MinesweeperController
  def initialize(minesweeper_model, minesweeper_view)
    @model = minesweeper_model
    @view = minesweeper_view
  end

  def request_difficult
    difficult = 0
    until [1, 2].include?(difficult)
      @view.show_difficults
      difficult = $stdin.gets.to_i
    end
    init_board(difficult)
  end

  def request_move
    x, y = -1, -1
    until valid_move(x, y)
      @view.show_valid_values(@model.obtain_number)
      @view.ask_next_move_x
      x = $stdin.gets.to_i
      @view.ask_next_move_y
      y = $stdin.gets.to_i
      move(x, y)
    end
  end

  def move(x, y)
    @model.change_status(y, x)
    @model.notify_all
    if @model.won
      @view.congratulations
    elsif @model.lose
      @view.lose_msg
    else
      request_move
    end
  end

  def valid_move(x, y)
    if !x.negative? && x <= @model.obtain_number && !y.negative? && y <= @model.obtain_number
      return true
    end
    return false
  end

  def init_board(difficult)
    @model.init_board(difficult)
    @view.print_board(@model)
  end
end
