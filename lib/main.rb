# frozen_string_literal: true

require_relative './minesweeper_model'
require_relative './minesweeper_controller'
require_relative './minesweeper_view'

model = MinesweeperModel.new
view = MinesweeperView.new
model.add_observer(view)
controller = MinesweeperController.new(model, view)
controller.view.request_difficult
controller.generate_board(controller.view.difficult)

until model.won || model.lose
  view.show_valid_values(model.number)
  view.ask_next_move_x
  pos_x = $stdin.gets.to_i
  view.ask_next_move_y
  pos_y = $stdin.gets.to_i
  controller.request_move(pos_x, pos_y)
end
