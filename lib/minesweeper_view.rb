# frozen_string_literal: true

require_relative './observer/observer'

# Vista del juego
class MinesweeperView < Observer
  def update(minesweeper_model)
    # Realizar update de la vista
  end

  def show_difficults
    puts 'Bienvenido a minesweeper'
    puts 'Dificultades:'
    puts "1) Facil (8x8 y 10 minas) \n2) Dificil(16x16 y 40 minas)"
    print 'Ingresa la dificultad deseada:'
  end

  def print_board(minesweeper_model)
    (0..minesweeper_model.obtain_number).step(1) do |row|
      print "\n |"
      (0..minesweeper_model.obtain_number).step(1) do |col|
        print minesweeper_model.obtain_mines_board[row][col].obtain_value
        print '|'
      end
    end
  end
end
