# frozen_string_literal: true

# Main class used to start game
class Game
  def initialize
    @board = { 1 => '1', 2 => '2', 3 => '3', 4 => '4', 5 => '5', 6 => '6', 7 => '7', 8 => '8', 9 => '9' }
    @turn_x = true
    @turn_y = false
    @condition = []
  end

  def print_board
    puts "_____________\n| #{@board[1]} | #{@board[2]} | #{@board[3]} |"
    puts "_____________\n| #{@board[4]} | #{@board[5]} | #{@board[6]} |"
    puts "_____________\n| #{@board[7]} | #{@board[8]} | #{@board[9]} |"
    puts '-------------'
  end

  def player_x_state
    @turn_x
  end

  def player_y_state
    @turn_y
  end

  def move(value)
    puts "Enter a value from the numeric cells to place #{value}: "
    cell = gets.chomp!.to_i
    if (@board.key? cell) && write_protect(cell)
      @board[cell] = value
      check_turn(value)
    else
      puts value_error
    end
    print_board
  end

  def check_turn(value)
    if value == 'X'
      @turn_x = false
      @turn_y = true
    else
      @turn_x = true
      @turn_y = false
    end
  end

  def write_protect(value)
    @board[value] == 'X' || @board[value] == 'O' ? false : true
  end

  def check_log
    @win = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @condition = @win.select { |i| [@board[i[0]], @board[i[1]], @board[i[2]]].uniq.size == 1 }
    if @condition.length == 1
      puts "Player #{@board[@condition[0][1]]} Won"
      true
    else
      false
    end
  end

  def board_full
    x_o = @board.select { |_, y| y != 'X' && y != 'O' }
    !x_o.length.positive?
  end

  def value_error
    'Value entered incorrectly'
  end

  def write_error
    "Can't write on an occupied cell"
  end

  def play
    puts 'Welcome to TicTacToe by Clumsyknight'
    print_board
    until board_full == true || check_log == true
      if player_x_state
        move('X')
      elsif player_y_state
        move('O')
      end
    end
  end
end

game = Game.new
game.play
