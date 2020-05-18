# die-roll-probabilities
A little helper to calculate die roll probabilities I wrote to solve a math problem

# Meta-Methods:
Written for when I plan on expanding this: Turns any method into a method that can be monte carlo'd.

### return_proc_from_method_and_arguments(method, *args)
Takes a method and a number of arguments and returns a proc

### mote_carlo_a_proc_that_returns_a_boolean(proc, number_of_attempts)
Runs a proc that results in a boolean a number of times, then returns the number of times they're successful.

# Methods

###roll_a_die(sides)
Rolls a die and returns a random result.

###roll_multiple_dice_and_return_hash_of_rolls(sides, number of dice)
Rolls a number of dice and returns a hash of number of times each side was rolled.
ie. {1: 0, 2: 1, 3: 1, 4: 0, 5: 0, 6: 3}

###amount_of_times_the_same_n_sides_were_rolled_from_hash(number_of_successful_sides, hash)
Used to check a hash of rolls to see how many times the first n sides were rolled.
ex: `amount_of_times_the_same_n_sides_were_rolled_from_hash(1, {1: 0, 2: 1, 3: 1, 4: 0, 5: 0, 6: 3})` => 0
ex: `amount_of_times_the_same_n_sides_were_rolled_from_hash(2, {1: 0, 2: 1, 3: 1, 4: 0, 5: 0, 6: 3})` => 1

###roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times(number_of_success_sides, total_sides, number_of_dice, minimum_number_for_success)
Combines the previous two methods to roll a number of n-sided dice a number of times, then check to see how many times it hit one of r 'successful sides' against a number needed for success, then returns true or false.
ex. Rolling 12d6 and seeing if the same 2 sides were rolled at least three times:
`roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times(2, 6, 12, 3)`

###monte_carlo_roll_dice_and_check_if_a_certain_number_of_sides_were_rolled_at_least_a_certain_number_of_times(number_of_success_sides, total_sides, number_of_dice, minimum_number_for_success, attempts)
Used to answer my specific question, allows you to ask if I 12d6 666 times, in how maany iterations would 1s and 2s be rolled at least three times
