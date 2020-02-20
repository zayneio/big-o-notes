# Big O Notation (asymptotic notation)

# Any dev given enought time can solve a problem. But how efficient is their solution?

# O(n) ==> Linear Time
# As the number of inputs (n) increase, the number of iterations 
# your algorithm must take increases proportionally (or linearly).

# # # Example # # #
# Find the index for the element if it exists in the array.
# @param array [Array] an array to search through
# @param element [String] the item to search for in the array
# @param index [Integer] element's index if found in the array
# @param iterations [Integer] number of iterations performed
def find_element(array, element, index=nil, iterations=0)
  array.each_with_index do |el, i| 
    index = i if el == element; iterations += 1
  end

  puts "index: #{index}, iterations: #{iterations}"
end

find_element([*0..999], 25)
# => index: 25, iterations: 1000


# O(1) ==> Constant Time
# Regardless of the number of inputs, performance is constant

# # # Example # # #
# Find the first element of the array
# @param array [Array]
def first_element(array)
  puts array.first
end


# Challenge: What is Big O of the below function? 
# (Hint, you may want to go line by line)
# Remember, loops are linear time
def challenge(input)
  a = 10 # 0(1) <- Should assignment count towards Big O? For now let's say yes.
  a = 50 + 3 # O(1)

  # Below, each step is O(n) (n === input.size)
  input.size.times do # <- should the iterator block itself count towards Big O? For now let's say no.
    # We don't know what this method is, but we know it will be called n times
    another_method # O(n)

    stranger = true # O(n)

    a += 1 # O(n)
  end

  a # O(1) <- Should returns count towards Big O? For now let's say yes.
end
# => Big O(3 + 3n)
# ( 3+ n + n + n )

# ^ because we can't be certain of what the input (n) might be, we simply say this is O(n)


# Some Big O Rules
  # - Rule 1: Worst Case
  # - Rule 2: Remove Constants
  # - Rule 3: Different Terms for Inputs
  # - Rule 4: Drop Non Dominants


# # # Rule 1: WORST CASE # # #

# Notice that our above `find_element` method is not very performant. 
# Regardless of wether the element we search for is in the first or last position of the array,
# our method loops through the array n times (where n is the full size of the array).
# We could potentially improve this slightly by using break:
def find_with_break(array, element, index=nil, iterations=0)
  array.each_with_index do |el, i|
    break index = i if el === element; iterations += 1
  end

  puts "index: #{index}, iterations: #{iterations}"
end

find_with_break([*0..999], 25)
# => index: 25, iterations: 25

# With break, we only iterate over the array until we find our match (25x instead of 1000), then stop.
# At the end of the day however, when talking about big O, we are concerned with the worst case scenario.
# Even though in the above example we only looped through the array 25 times to find our item, the worst 
# case scenario would be that the item we are looking for is the last item in the array. 
# in this case, we would have had to loop through the array 1000 times.

# So our first rule is - we always care about what is the worst case scenario for our algorithm?
# Even though it's possible our algorithm could be O(1) if the item we are looking for is first in the array,
# it doesn't matter because we can't be certain what the input is going to be. 
# So then we will assume O(n) - Linear Time.



# # # Rule 2: REMOVE CONSTANTS # # #
# Let's take a random example method, what is big O?:
def random(input)
  index = 0 # O(1)
  middle = input/2 # O(1)

  while index < middle
    index += 1 # O(n)
  end

  100.times do { puts 'hi' } # O(100)
end
# Initially, we might say 1 + 1 + n/2 + 100 = O(n/2 + 102)
# But rule 2 is we want to drop the constants. We don't really care that big O here is O(n/2 + 102),
# because in the grand scheme of things, we are focused on scalability; i.e. what happens when our 
# inputs are getting larger and larger. As n gets bigger and bigger, we aren't concerned with an extra 100,
# or that it is n/2, because this has a diminishing impact if our input size is something in the millions
# or hundreds of millions for example. So we drop the constants and reduce this down to simply be O(n).

# With Big O, we don't really care how steep the line is (assuming a graph of # of operations vs # of elements).
# We care about how the line moves as our input increases.



# # # Rule 3: DIFFERENT TERMS FOR INPUTS # # #