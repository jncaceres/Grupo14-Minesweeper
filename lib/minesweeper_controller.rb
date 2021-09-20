# frozen_string_literal: true

# Controlador del juego
class MinesweeperController
  def initialize(minesweeper_model, minesweeper_view)
    @model = minesweeper_model
    @view = minesweeper_view
  end
end
