class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def prompt
    puts "Enter your move (i.e 1, 3) or save"
    input = gets.chomp
    return input if input == 'save'
    position = input.split(", ").map(&:to_i)
    puts "Toggle flag or reveal? ( f or r )"
    move = gets.chomp
    [position, move]
  end

  def wait_for_input
  c = read_char

  case c
  when "f"
  when "F"
    puts "F"
  when "\r"
    puts "RETURN"
  when "\e[A"
    puts "UP ARROW"
  when "\e[B"
    puts "DOWN ARROW"
  when "\e[C"
    puts "RIGHT ARROW"
  when "\e[D"
    puts "LEFT ARROW"
  when "\u0003"
    puts "CONTROL-C"
    exit 0
  end
end




  private

  ## DO NOT TOUCH!
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
end
