require "io/console"
require_relative 'display'

class HumanPlayer
  attr_accessor :color, :name

  KEYMAP = {
      "q" => :exit,
      "\r" => :enter,
      " " => :enter,
      "w" => :up,
      "a" => :left,
      "s" => :down,
      "d" => :right,
      "\e[A" => :up,
      "\e[B" => :down,
      "\e[C" => :right,
      "\e[D" => :left
    }

  def initialize(name,display)
    @name = name
    @display = display
    @color = :w #default color
  end

  def get_input
    key = KEYMAP[read_input]
    @display.handle_key(key)
  end

  def render(board)
    @display.render(board)
  end

  private
  def read_input
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
