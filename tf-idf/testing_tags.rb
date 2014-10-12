require './tf_idf.rb'

collect = ["Test test test other words test I think that test and words should be not unique test right words?", "test", "ass", "test", "test", "test", "test"]
doc = "Test ass butt?"
test = TfIdf::WeightedTags.new(collect, doc)
puts test.get_weighted_tags