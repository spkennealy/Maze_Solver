# Maze Solver

Provided a maze with a start ("S") and end ("E"), this program will find a route to get from the start to the end without hitting a wall ("*") or backtracking. 

## How to Use

```bash
ruby maze.rb  
```

## Run with a Different Maze

1. Open maze.rb  
2. Save new maze text file to directory.  
3. Add in new maze text file into parenthesis after .new:  
```ruby
maze1 = Maze.new(NEW_MAZE_FILE)  
```
4. Run:  
```bash
ruby maze.rb  
```