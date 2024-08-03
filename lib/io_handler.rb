# # frozen_string_literal: true

require 'io/console'

# Module to handle input/output
module IOHandler

  def prompt_name(player_id)
    puts "Player #{player_id}"
    puts 'Enter your name:'

    name = gets.chomp

    clear_screen
    name
  end

  def display_error_msg
    puts @error_msg unless @error_msg.nil?
    @error_msg = nil
  end

  def prompt_for_single_char
    input = $stdin.getch
    begin
      input += $stdin.read_nonblock(2)
    rescue IO::WaitReadable
      nil
    end
    input
  end

  def display_move_prompt_text
    puts 'Use arrow keys to move, press enter to submit'
  end

  def clear_screen
    puts "\e[2J"
  end
end
