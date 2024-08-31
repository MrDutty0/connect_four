# frozen_string_literal: true

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

  def display_move_prompt_text(player_name)
    puts "#{player_name}'s turn"
    puts 'Use arrow keys to move, press enter to submit'
  end

  def clear_screen
    puts "\e[2J"
  end

  def display_win_message(player_name)
    clear_screen

    puts "Congrats, #{player_name}, you have won!"
  end

  def display_tie_message
    clear_screen

    puts 'Good try, but the game is tied'
  end

  def prompt_replay
    puts 'Do you want to play again? (y/n)'
    prompt_for_single_char
  end

  def display_intro_text
    clear_screen

    puts 'Welcome to Connect four!'
  end
end
