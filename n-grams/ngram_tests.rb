require './ngram.rb'

puts "testing bigrams: "
gram_test = Ngram.new("Hi my name is Carl. I like Pie!")
print gram_test.grams(2)

puts "\n testing bigram analysis: "
analysis_test = Ngram.new("The quick brown fox jumps over the lazy dog, ya dingus! Now go and get yourself some quick brown foxes, ya dingus.")
puts analysis_test.bigram_probabilities
