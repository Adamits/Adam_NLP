class Text
  # This class is used to create tokens
  # Out of a string that is passed in the parameter of the object.new() call
  # And compare against a text file of delimited words that
  # Should not be returned.

  def initialize(content)
    # Instantiate the instance variable to be returned
    @tokens = Array.new
    # Store the set of no_tag words from the file,
    # And the content, with filtered out punctuation
    # In all lowercase local variables
    no_tag = File.read("do_not_tag.txt");
    no_tag.downcase!
    raw_string = content.gsub(/[^a-zA-Z0-9 - ']/, "")
    raw_string.downcase!

    # Make arrays of all the words, all lowercase, 
    # For both sets of words, and store in instance variables.
    @tokens_array = raw_string.split(' ')
    @no_tag_array = no_tag.split("~")
    @no_tag_array.uniq!
  end

	def get_tokens
    tokenize_into_tags
		return @tokens
	end

  private
  # Appends each word that 
  # Does not match anything in the 
  # file do_not_tag.txt to @tokens
  def tokenize_into_tags
    # Alphabetize both arrays
    @no_tag_array.sort!
    @tokens_array.sort!

    # Instantiate iterators
    tokens_iterator = 0
    no_tag_iterator = 0

    # Loop through the two arrays of words to compare
    # Until the array of content words is fully traversed
    while @tokens_array[tokens_iterator]
      # Check if the no_tag list has been fully traversed.
      # And if so, append the rest of the tokens fom the input content to @tokens
      if @no_tag_array[no_tag_iterator]  == nil
          @tokens.push(@tokens_array[tokens_iterator])
          tokens_iterator+=1
      else
        # If no_tag is farther in the alphabet, add the token to
        # The return list of tags, and increment to the next token in @tokens_array
        if @no_tag_array[no_tag_iterator] > @tokens_array[tokens_iterator]
          @tokens.push(@tokens_array[tokens_iterator])
          tokens_iterator+=1
        # If @tokens_array is farther in the alphabet, increment to 
        # The next no_tag word.
        elsif @no_tag_array[no_tag_iterator] < @tokens_array[tokens_iterator]
          no_tag_iterator+=1
        # If they match, increment both array indices
        else
          # If there are duplicates in tokens_array, check them all against the current no_tag word
          # So that the algorithm continues to traverse both lists equally.
          if @tokens_array[tokens_iterator] == @tokens_array[tokens_iterator + 1]
            tokens_iterator+=1 
          else 
            no_tag_iterator+=1 
            tokens_iterator+=1 
          end
        end
      end
    end
  end
end