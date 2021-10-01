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
