class Game
    
    @board = {1=> '1', 2=> '2', 3=> '3', 4=> '4', 5=> '5', 6=> '6', 7=> '7', 8=> '8', 9=> '9'}
    $turn_x = true
    $turn_y = false
    $condition = []
    def printBoard
        puts "_____________"
        puts "| #{@board[1]} | #{@board[2]} | #{@board[3]} |"
        puts "_____________"
        puts "| #{@board[4]} | #{@board[5]} | #{@board[6]} |"
        puts "_____________"
        puts "| #{@board[7]} | #{@board[8]} | #{@board[9]} |"
        puts "-------------"
    end
  
    def player_x_state
        return $turn_x
    end
    
    def player_y_state
        return $turn_y
    end
    
    def move(value)
        puts "Enter a value from the numeric cells to place #{value}: "
        cell = gets.chomp!.to_i
        if @board.has_key? cell and write_protect(cell)
            @board[cell]=value
            if value=='X'
                $turn_x = false
                $turn_y = true
            else
                $turn_x = true
                $turn_y = false
            end
            printBoard
        else
            puts value_error
            printBoard
        end
    end
    
    def write_protect(value)
        if @board[value] =='X' || @board[value] =='O'
            return false
        else
            return true
        end
    end

    def check_log
        @WIN = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
        $condition = @WIN.select {|i| [@board[i[0]], @board[i[1]], @board[i[2]]].uniq.size == 1}
        
        if $condition.length==1
            puts "Player #{@board[$condition[0][1]]} Won" 
            return true
        else
            return false
        end
    end

    def board_full
        x_o = @board.select{ |x,y|  y!='X' and y!='O'}
        return x_o.length>0?false:true
    end

    def value_error
        "Value entered incorrectly "
    end

    def write_error
        "Can't write on an occupied cell"
    end
    
    def play
        puts "Welcome to TicTacToe by Clumsyknight"

        printBoard
        until board_full == true or check_log == true do

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