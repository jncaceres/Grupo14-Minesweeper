# frozen_string_literal: true

# Controlador del juego
class MinesweeperController
  attr_accessor :model, :view, :pos_x, :pos_y

  def initialize(minesweeper_model, minesweeper_view)
    @model = minesweeper_model
    @view = minesweeper_view
    @pos_x = -1
    @pos_y = -1
  end

  def request_move(pos_x, pos_y)
    if valid_move(pos_x, pos_y)
      @pos_x = pos_x
      @pos_y = pos_y
      move(@pos_x, @pos_y)
    end
    @pos_x = -1
    @pos_y = -1
  end

  def move(move_x, move_y)
    @model.change_status(move_y, move_x)
    @model.notify_all
    if @model.won
      @view.congratulations
    elsif @model.lose
      @view.lose_msg
    end
  end

  def valid_move(valid_x, valid_y)
    return true if !valid_x.negative? && valid_x <= @model.number && !valid_y.negative? && valid_y <= @model.number

    false
  end

  def generate_board(difficult)
    @model.init_board(difficult)
    @view.print_board(@model)
  end
end
