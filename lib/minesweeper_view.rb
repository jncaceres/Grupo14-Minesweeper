# frozen_string_literal: true

require_relative './observer/observer'

# Vista del juego
class MinesweeperView < Observer
  def update(minesweeper_model)
    print_board(minesweeper_model)
  end

  def show_difficults
    puts 'Bienvenido a minesweeper'
    puts 'Dificultades:'
    puts "1) Facil (8x8 y 10 minas) \n2) Dificil(16x16 y 40 minas)"
    print 'Ingresa la dificultad deseada:'
  end

  def ask_next_move_x
    puts 'Ingrese una coordenada x para revelar'
  end

  def ask_next_move_y
    puts 'Ingrese una coordenada y para revelar'
  end

  def show_valid_values(max_number)
    puts "Ingrese coordenadas entre 0 y #{max_number}"
  end

  def print_board(minesweeper_model)
    (0..minesweeper_model.obtain_number).step(1) do |row|
      print "\n |"
      (0..minesweeper_model.obtain_number).step(1) do |col|
        if minesweeper_model.obtain_mines_board[row][col].status
          print minesweeper_model.obtain_mines_board[row][col].obtain_value
        else
          print ' '
        end
        print '|'
      end
    end
    print "\n"
  end

  def lose_msg
    puts 'Haz perdido, gracias por haber jugado'
  end

  def congratulations
    puts 'Haz ganado!!! Felicitaciones'
  end
end
