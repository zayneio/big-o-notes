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

  100.times { puts 'hi' } # O(100)
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
# What is Big O for the below method?
# Example method:
def double_loop(array1, array2)
  array1.each do |arr|
    puts arr # O(n)
  end

  array2.each do |arr|
    puts arr # O(n)
  end
end

# Initially we might think this is O(2n) (n + n), and after applying rule 2 this become O(n)
# however this is incorrect.
# Rule 3 states we must use different terms for different inputs.
# So Big O for this method would actually be something like O(a + b)

# But what happens if these loops are nested?
# Challenge: Log all pairs of array [*1..5] (ex: [[1,1], [1,2], [1,3]...[2,1], [2,2]...])
# Here's my first approach:
def log_all_pairs(array)
  result = array.each_with_object([]) do |item, obj|
    index = 0

    while index < array.size
      obj.push([item, array[index]])

      index += 1
    end
  end

  p result
end

log_all_pairs([*1..5])
# => [[1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [5, 1], [5, 2], [5, 3], [5, 4], [5, 5]]


# second approach:
def log_all_pairs2(array)
  result = array.each_with_object([]).with_index do |(_, obj), i|
    array.each_with_index do |_, j|
      obj << [array[i], array[j]]
    end
  end
end

log_all_pairs2([*1..5])

# Rule of thumb for big O - when calculating big O, if you see nested loops, don't add, multiply.
# So this method becomes O(n * n), or O(n^2)
# This means when elements get added, our methods # of operations increases quadratically.
# The take away here is that as our input (array) increases, the # of operations for this method increases dramatically.

# Tieing this back to rule 3, what would have happened if instead of nesting the same input, 
# we had 2 diff inputs?
# => Big O for this would become O(a * b) instead of O(n^2)


# # # Rule 4: DROP NONDOMINANTS # # #
# Example method:
def sum_numbers(nums)
  nums.each { |n| puts n }

  nums.each do |augend|
    nums.each do |addend|
      puts augend + addend
    end
  end
end

# In this example, we first loop through our args so we have O(n), then we create a nested loop
# to get the sum of all our number pairs, which is O(n)
# So big O for this is O(n + n^2). 
# However, rule 4 is that we basically aren't concerned with the nondominant value.
# So ultimately Big O for this will end up being O(n^2)

