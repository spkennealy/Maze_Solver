#   In this exercise, we want to write a program that will find a route between 
# two points in a maze. Here's an example maze. It has an 'S' for the start 
# point, and an 'E' for an end point.
#   You should write a program that will read in the maze, try to explore a path 
# through it to the end, and then print out a completed path like so. If there 
# is no such path, it should inform the user.
#   Make your program run as a command line script, taking in the name of a maze 
# file on the command line. Your path through the maze should not be 
# self-intersecting, of course. When you have found a first solution, write a 
# version which will be sure to find the shortest path through the maze.

require "colorize"
require "colorized_string"

class Maze

    attr_reader :maze, :start, :end, :current_position

    def initialize(maze_file)
        @maze = File.readlines(maze_file).map(&:chomp).map(&:chars)
        @start = find_start
        @end = find_end
        @current_position = @start.dup
    end 

    def find_start
        @maze.each_with_index do |row, row_idx|
            row.each_with_index do |square, square_idx|
                return [row_idx, square_idx] if square == "S"
            end 
        end 
    end 

    def find_end
        @maze.each_with_index do |row, row_idx|
            row.each_with_index do |square, square_idx|
                return [row_idx, square_idx] if square == "E"
            end 
        end 
    end 

    def move_up(pos)
        pos[0] -= 1
        return false if wall?(pos) || self_intersecting?(pos)
        true
    end 

    def move_down(pos)
        pos[0] += 1
        return false if wall?(pos) || self_intersecting?(pos)
        true
    end

    def move_left(pos)
        pos[1] -= 1
        return false if wall?(pos) || self_intersecting?(pos)
        true
    end

    def move_right(pos)
        pos[1] += 1
        return false if wall?(pos) || self_intersecting?(pos)
        true
    end

    def wall?(pos)
        return true if @maze[pos[0]][pos[1]] == "*"
        false
    end 

    def self_intersecting?(pos)
        return true if @maze[pos[0]][pos[1]] == "X"
        false 
    end 

    def drop_X(pos)
        @maze[pos[0]][pos[1]] = "X"
    end 

    def maze_solved?
        @current_position == @end
    end 

    def find_solution
        until maze_solved?
            if @current_position[1] <= @end[1] && move_right(@current_position.dup)
                move_right(@current_position)
                drop_X(@current_position)
                render_maze
                sleep(0.5)
                system("clear")
            elsif @current_position[0] >= @end[0] && move_up(@current_position.dup)
                move_up(@current_position)
                drop_X(@current_position)
                render_maze
                sleep(0.5)
                system("clear")
            elsif @current_position[0] <= @end[0] && move_down(@current_position.dup) || @current_position[0] >= @end[0] && move_down(@current_position.dup)
                move_down(@current_position)
                drop_X(@current_position)
                render_maze
                sleep(0.5)
                system("clear")
            else 
                move_left(@current_position)
                drop_X(@current_position)
                render_maze
                sleep(0.5)
                system("clear")
            end 
        end 
        render_maze

        puts ""
        puts ""
        puts "                               ".on_white
        puts "-------- MAZE COMPLETED -------".bold.on_blue
        puts "                               ".on_white
        puts "--------- BOOOYAKASHA! --------".bold.on_red
        puts "                               ".on_white
        puts ""
        puts ""
    end 

    def render_maze
        puts "------------- MAZE ------------".cyan
        @maze.each do |row|
            row.each do |square|
                if square == "*"
                    print "* ".yellow
                elsif square == "S"
                    print "S ".green.bold
                elsif square == "E"
                    print "E ".red.bold
                else 
                    print square + " "
                end
            end 
            puts ""
        end 
    end 

    # def [](pos)
    #     @maze[pos[0]][pos[1]]
    # end 

    # def []=(pos, value)
    #     @maze[pos[0]][pos[1]] = value
    # end 
end 


maze1 = Maze.new("maze1.txt")
system("clear")
# maze1.render_maze
# puts ""
# puts "---- START POINT ----".red
# puts "       #{maze1.find_start}"
# puts "" 
# puts "----- END POINT -----".blue
# puts "       #{maze1.find_end}"
# puts "" 
# p maze1.current_position
# new_position = [0, 0]
# p maze1.wall?(new_position)
maze1.find_solution

