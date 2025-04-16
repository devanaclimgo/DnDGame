class DnDGame
  SCENARIOS = [
    "You encouter a goblin in the dark forest. What do you do?",
    "A mysterious stranger offers you a quest. How do you respond?",
    "You find a treasure chest! Do you open it?",
    "The bridge ahead looks rickety. What's your move?",
    "A man in a horse seems to be following you. What do you do?"
  ]

  ACTIONS = {
    "fight" => { descrition: "Engage in combat", difficulty: 15 },
    "talk" => { descrition: "Attempt diplomacy", difficulty: 10 },
    "flee" => { descrition: "Run away", difficulty: 5 },
    "flirt" => { descrition: "Try to charm", difficulty: 18 },
    "inspect" => { descrition: "Examine carefully", difficulty: 12 },
  }

  def initialize
    @scenario = SCENARIOS.sample
    @health = 10
    @alive = true
  end

  def play
    puts "\n=== D&D Terminal Adventure ===\n\n"
    puts @scenario
    puts "\nAvailable actions:"
    ACTIONS.each { |k, v| puts "#{k.ljust(8)} - #{v[:description]}"}

    action = gets.chomp.downcase

    if ACTIONS.key?(action)
      attempt_action(action)
    else
      puts "Invalid action! Try again."
      play
    end
  end

  def attempt_action(action)
    roll = rand(1..20)
    difficulty = ACTIONS[action][:difficulty]

    puts "\nYou rolled a #{roll} (needed #{difficulty})"

    if roll >= difficulty
      puts "Success! #{success_outcome(action)}"
    else
      puts "Failure! #{failure_outcome(action)}"
      @health -= 2 if action == "fight"
    end

    check_health
    play if @alive
  end

  def success_outcome(action)
    case action
    when "fight" then "You defeated your foe!"
    when "talk" then "They agree to your terms."
    when "flee" then "You escaped safely."
    when "flirt" then "They're charmed by your wit."
    when "inspect" then "You notice important details."
    end
  end

  def failure_outcome(action)
    case action
    when "fight" then "You take damage in the fight!"
    when "talk" then "They don't trust you."
    when "flee" then "You trip while running!"
    when "flirt" then "They're not impressed."
    when "inspect" then "You miss something important."
    end
  end

  def check_health
    if @health <= 0
      @alive = false
      puts "\nYou have died! Game over."
    else
      puts "Health: #{@health}/10"
    end
  end
end

game = DnDGame.new
game.play