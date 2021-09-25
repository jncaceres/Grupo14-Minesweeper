# frozen_string_literal: true

require_relative './minesweeper_model'
require_relative './minesweeper_controller'
require_relative './minesweeper_view'

model = MinesweeperModel.new
view = MinesweeperView.new
model.add_observer(view)
controller = MinesweeperController.new(model, view)
controller.request_difficult
controller.request_move
