# Single matches return a MatchData object
# (note the use of the /i flag in the RegExp to make it case-insensitive)
"one two ONE TWO".match(/one/i)        # => #<MatchData "one">
"one two ONE TWO".match(/one/i).class  # => MatchData

# Use index notation to access the "match groups"
"one two ONE TWO".match(/one/i)[0]      # => "one"
# In this case, there is only one
"one two ONE TWO".match(/one/i).length  # => 1

# Use parens to create more match groups
"one two ONE TWO".match(/(one)\s*(two)/i)         # => #<MatchData "one two" 1:"one" 2:"two">
"one two ONE TWO".match(/(one)\s*(two)/i).length  # => 3
"one two ONE TWO".match(/(one)\s*(two)/i)[0]      # => "one two"
"one two ONE TWO".match(/(one)\s*(two)/i)[1]      # => "one"
"one two ONE TWO".match(/(one)\s*(two)/i)[2]      # => "two"

# Use the offset method of MatchData to get the start and end offests of the
# match group you want
"one two one two".match(/one/i).offset(0)            # => [0, 3]
"one two ONE TWO".match(/one/i, 3)                   # => #<MatchData "ONE">
"one two ONE TWO".match(/one/i, 3)[0]                # => "ONE"
"one two ONE TWO".match(/(one)\s*(two)/i).offset(2)  # => [4, 7]
"one two ONE TWO".match(/(one)\s*(two)/i, 4)         # => #<MatchData "ONE TWO" 1:"ONE" 2:"TWO">
"one two ONE TWO".match(/(one)\s*(two)/i, 4)[0]      # => "ONE TWO"

# Or you can just use scan...
"one two ONE TWO".scan(/one/i)  # => ["one", "ONE"]
