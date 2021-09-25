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

  def init_board(difficult)
    @model.init_board(difficult)
    @view.print_board(@model)
  end
end
