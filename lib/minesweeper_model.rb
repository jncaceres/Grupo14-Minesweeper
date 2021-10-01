# frozen_string_literal: true

require_relative './observer/observable'
# Modelo del juego
class MinesweeperModel < Observable
  attr_accessor :mines_board, :positions, :number

  def initialize
    @mines_board = []
    @positions = []
    @number = 0
    super()
  end

  def init_board(difficult)
    if difficult == 1
      @number = 7
      create_board(@number)
    end
    if difficult == 2
      @number = 15
      create_board(@number)
    end
  end

  def create_board(number)
    (0..number).step(1) do |_|
      fila = []
      (0..number).step(1) do |_|
        celda = Cell.new
        fila.append(celda)
      end
      @mines_board.append(fila)
    end
    add_mines(number)
    add_numbers(number)
  end

  def obtain_mines_positions(number)
    mines = if number == 7
              10
            else
              40
            end
    while @positions.length != mines
      x = rand(number + 1)
      y = rand(number + 1)
      @positions.append([x, y]) unless @positions.include?([x, y])
    end
  end

  def add_mines(number)
    obtain_mines_positions(number)
    @positions.each do |position|
      @mines_board[position[1]][position[0]].give_value('*')
    end
  end

  def add_numbers(number)
    (0..number).step(1) do |row|
      (0..number).step(1) do |col|
        check_coor(row, col, number, true) if @mines_board[row][col].obtain_value != '*'
      end
    end
  end

  def check_coor(row, col, number, count)
    coordenates = [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0]]

    coordenates -= [[-1, -1], [-1, 1], [-1, 0]] if (row - 1).negative?
    coordenates -= [[-1, -1], [0, -1], [1, -1]] if (col - 1).negative?
    coordenates -= [[1, -1], [1, 1], [1, 0]] if (row + 1) > number
    coordenates -= [[-1, 1], [0, 1], [1, 1]] if (col + 1) > number
    if count
      count_mines(row, col, coordenates)
    else
      change_status_caller(row, col, coordenates)
    end
  end

  def count_mines(row, col, coordenates)
    count = 0
    coordenates.each do |coor|
      count += 1 if @mines_board[row + coor[0]][col + coor[1]].obtain_value == '*'
    end
    @mines_board[row][col].give_value(count)
  end

  def change_status_caller(row, col, coordenates)
    coordenates.each do |coor|
      new_row = row + coor[0]
      new_col = col + coor[1]
      if !@mines_board[new_row][new_col].status && @mines_board[new_row][new_col].obtain_value != '*'
        change_status(new_row, new_col)
      end
    end
  end

  def change_status(row, col)
    @mines_board[row][col].show
    return unless (@mines_board[row][col].obtain_value.is_a? Numeric) && @mines_board[row][col].obtain_value.zero?

    check_coor(row, col, @number, false)
  end

  def won
    (0..@number).step(1) do |row|
      (0..@number).step(1) do |col|
        return false if @mines_board[row][col].obtain_value != '*' && !@mines_board[row][col].status
      end
    end
    true
  end

  def lose
    (0..@number).step(1) do |row|
      (0..@number).step(1) do |col|
        return true if @mines_board[row][col].obtain_value == '*' && @mines_board[row][col].status
      end
    end
    false
  end
end

# Clase para modelar una celda
class Cell
  def initialize
    @show = false
    @value = ''
  end

  def give_value(new_value)
    @value = new_value
  end

  def show
    @show = true
  end

  def status
    @show
  end

  def obtain_value
    @value
  end
end
