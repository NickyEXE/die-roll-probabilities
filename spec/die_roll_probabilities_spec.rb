require_relative '../die_roll_probabilities.rb'

RSpec.describe "Die Rolls" do
    it "can roll a die" do
        result = roll_a_die(2)
        expect(result).to be <=2
    end

    it "can roll multiple dice" do
        result = roll_multiple_dice(2, 666)
        expect(result[1] + result[2]).to eq 666
    end

    it "can find how many times the first two sides were rolled on a number of rolls of three sided dice" do
        hash = {1=> 2, 2=> 1, 3=> 6}
        number_of_successful_sides = 2
        expect(times_same_n_sides_were_rolled(number_of_successful_sides, hash)).to eq 3
    end


end
