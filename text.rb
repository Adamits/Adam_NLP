class Text
  # This class is used to create tokens
  # Out of a string that is passed in the parameter of the object.new() call
  # And compare against a text file of delimited words that
  # Should not be returned.

  def initialize(content)
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
    @tokens = Array.new

    # Alphabetize both arrays
    @no_tag_array.sort!
    @tokens_array.sort!
    puts @tokens_array
    puts ' '
    puts @no_tag_array
    puts ' '
    # Get size of larger array so we know how many times to iterate
    no_tag_length = @no_tag_array.length
    tokens_length = @tokens_array.length
    if no_tag_length > tokens_length
      array_size = no_tag_length
    else
      array_size = tokens_length
    end

    # Instantiate iterators
    i = 0
    tokens_iterator = 0
    no_tag_iterator = 0
    # Loop through the two arrays of words to compare
    while @tokens_array[tokens_iterator]
      # Check if the no_tag list has been fully traversed.
      # And if so, append the rest of the tokens to @tokens
      if @no_tag_array[no_tag_iterator]  == nil
        if (@tokens_array[tokens_iterator])
          @tokens.push(@tokens_array[tokens_iterator])
          tokens_iterator+=1
        end
      else
        # If no_tag is farther in the alphabet, add the token to
        # The return list of tags, and increment to the next token in @tokens_array
        if @no_tag_array[no_tag_iterator] > @tokens_array[tokens_iterator]
          @tokens.push(@tokens_array[tokens_iterator])
          tokens_iterator+=1
          i+=1
        # If @tokens_array is farther in the alphabet, increment to 
        # The next no_tag word.
        elsif @no_tag_array[no_tag_iterator] < @tokens_array[tokens_iterator]
          no_tag_iterator+=1
          i+=1
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