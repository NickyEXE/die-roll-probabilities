require 'pry'

### Meta-methods for monte-carloing
def return_proc_from_method_and_arguments(method, *args)
    Proc.new{|i| self.send(method, *args)}
end

def monte_carlo_a_proc_that_returns_a_boolean(proc, number_of_attempts)
    successes = 0
    number_of_attempts.times do |i|
        if proc.call
            successes += 1
        end
    end
    return successes.to_f/number_of_attempts
end

### Die roll methods
def roll_a_die(sides)
    rand(sides) + 1
end

# roll_multiple_dice_and_return_hash_of_rolls(6, 5)
# -> {1: 0, 2: 1, 3: 1, 4: 0, 5: 0, 6: 3}
def roll_multiple_dice_and_return_hash_of_rolls(sides, number_of_dice)
    array_of_potential_sides = Array(1..sides)
    hash_of_rolls = Hash[array_of_potential_sides.collect { |item| [item, 0] } ]
    number_of_dice.times do |i|
        hash_of_rolls[roll_a_die(sides)] +=1
    end
    return hash_of_rolls
end

# Used to check a hash of rolls to see how many times the first n sides were rolled.
# amount_of_times_the_same_n_sides_were_rolled_from_hash(1, {1: 0, 2: 1, 3: 1, 4: 0, 5: 0, 6: 3}) => 0
# amount_of_times_the_same_n_sides_were_rolled_from_hash(2, {1: 0, 2: 1, 3: 1, 4: 0, 5: 0, 6: 3}) => 1
def amount_of_times_the_same_n_sides_were_rolled_from_hash(number_of_successful_sides, hash)
    Array(1..number_of_successful_sides).reduce(0){|sum, side| sum += hash[side]}
end


# Rolls a number of n-sided dice a number of times, then checks to see how many times it hit one of r 'successful sides' against a number needed for success
# then returns true or false
# ex. Rolling 12d6 and seeing if the same 2 sides were rolled at least three times:
# -> roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times(2, 6, 12, 3)
def roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times(number_of_success_sides, total_sides, number_of_dice, minimum_number_for_success)
    hash = roll_multiple_dice_and_return_hash_of_rolls(total_sides, number_of_dice)
    total_successes = amount_of_times_the_same_n_sides_were_rolled_from_hash(number_of_success_sides, hash)
    total_successes >= minimum_number_for_success
end

# Rolling 12d6 420 times and seeing how many of those times 1s and 2s were rolled at least three times
# monte_carlo_roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times(2, 6, 12, 3, 420)
def monte_carlo_roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times(number_of_success_sides, total_sides, number_of_dice, minimum_number_for_success, attempts)
    proc = return_proc_from_method_and_arguments(:roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times, number_of_success_sides, total_sides, number_of_dice, minimum_number_for_success)
    monte_carlo_a_proc_that_returns_a_boolean(proc, attempts)
end

# return_proc_from_method_and_arguments(:monte_carlo_roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times, 2, 6, 12, 3, 420)

binding.pry