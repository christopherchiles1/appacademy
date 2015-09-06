require 'io/console'
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
  #empty until AI section
  #will have HumanPlayer and ComputerPlayer classes too
  def prompt
    puts "Pick a card, any card! (Row #, Column #)"
    input = get_input.split(", ")
    input.map!(&:to_i)
  end

  def get_input
    #STDIN.gets.chomp
    read_char
  end

    # Reads keypresses from the user including 2 and 3 escape character sequences.
  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  # oringal case statement from:
  # http://www.alecjacobson.com/weblog/?p=75

end
