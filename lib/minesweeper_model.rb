# frozen_string_literal: true

require_relative './observer/observable'
# Modelo del juego
class MinesweeperModel < Observable
  def initialize
    @mines_board = []
    @positions = []
    @number = 0
    super()
  end

  def obtain_number
    @number
  end

  def obtain_mines_board
    @mines_board
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
        if @mines_board[row][col].obtain_value != '*'
          count = 0
          count += 1 if !(row - 1).negative? && !(col - 1).negative? && @mines_board[row - 1][col - 1].obtain_value == '*'
          count += 1 if !(row - 1).negative? && @mines_board[row - 1][col].obtain_value == '*'
          count += 1 if !(row - 1).negative? && (col + 1) <= number && @mines_board[row - 1][col + 1].obtain_value == '*'
          count += 1 if !(col - 1).negative? && @mines_board[row][col - 1].obtain_value == '*'
          count += 1 if (col + 1) <= number && @mines_board[row][col + 1].obtain_value == '*'
          count += 1 if (row + 1) <= number && !(col - 1).negative? && @mines_board[row + 1][col - 1].obtain_value == '*'
          count += 1 if (row + 1) <= number && @mines_board[row + 1][col].obtain_value == '*'
          count += 1 if (row + 1) <= number && (col + 1) <= number && @mines_board[row + 1][col + 1].obtain_value == '*'
          @mines_board[row][col].give_value(count)
        end
      end
    end
  end

  def change_status(row, col)
    @mines_board[row][col].show
    if (@mines_board[row][col].obtain_value.is_a? Numeric) && @mines_board[row][col].obtain_value.zero?
      change_status(row - 1, col - 1) if !(row - 1).negative? && !(col - 1).negative? && @mines_board[row - 1][col - 1].obtain_value != '*' && !@mines_board[row - 1][col - 1].status
      change_status(row - 1, col) if !(row - 1).negative? && @mines_board[row - 1][col].obtain_value != '*' && !@mines_board[row - 1][col].status
      change_status(row - 1, col + 1) if !(row - 1).negative? && (col + 1) <= @number && @mines_board[row - 1][col + 1].obtain_value != '*' && !@mines_board[row - 1][col + 1].status
      change_status(row, col - 1) if !(col - 1).negative? && @mines_board[row][col - 1].obtain_value != '*' && !@mines_board[row][col - 1].status
      change_status(row, col + 1) if (col + 1) <= @number && @mines_board[row][col + 1].obtain_value != '*' && !@mines_board[row][col + 1].status
      change_status(row + 1, col - 1) if (row + 1) <= @number && !(col - 1).negative? && @mines_board[row + 1][col - 1].obtain_value != '*' && !@mines_board[row + 1][col - 1].status
      change_status(row + 1, col) if (row + 1) <= @number && @mines_board[row + 1][col].obtain_value != '*' && !@mines_board[row + 1][col].status
      change_status(row + 1, col + 1) if (row + 1) <= @number && (col + 1) <= @number && @mines_board[row + 1][col + 1].obtain_value != '*' && !@mines_board[row + 1][col + 1].status
    end
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
