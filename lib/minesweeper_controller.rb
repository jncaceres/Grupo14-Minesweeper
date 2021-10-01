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

  # def request_difficult
  #   until [1, 2].include?(difficult)
  #     @view.show_difficults
  #     @difficult = $stdin.gets.to_i
  #   end
  #   init_board(@difficult)
  # end

  def request_move
    until valid_move(pos_x, pos_y)
      @view.show_valid_values(@model.obtain_number)
      @view.ask_next_move_x
      @pos_x = $stdin.gets.to_i
      @view.ask_next_move_y
      @pos_y = $stdin.gets.to_i
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
    else
      request_move
    end
  end

  def valid_move(valid_x, valid_y)
    if !valid_x.negative? && valid_x <= @model.obtain_number && !valid_y.negative? && valid_y <= @model.obtain_number
      return true
    end

    false
  end

  def init_board(difficult)
    @model.init_board(difficult)
    @view.print_board(@model)
  end
end
