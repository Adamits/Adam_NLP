require './tf_idf.rb'

collect = ["Test test test other words test I think that test and words should be not unique test right words?", "test words", "ass", "test words", "test", "test", "test", "don't"]
doc = "Test words, unique don't it?"
test = TfIdf::WeightedTags.new(collect, doc)
puts test.all
print "\n test.first: #{test.first}"
puts "\n test.first(2):  #{test.first(2)}"
puts "\n test.tags:  #{test.tags}"
puts "\n test.tags(3):  #{test.tags(3)}"
puts "\n test.weighted_scores(3):  #{test.weighted_scores(3)}"
puts "\n test.weighted_scores:  #{test.weighted_scores}"
