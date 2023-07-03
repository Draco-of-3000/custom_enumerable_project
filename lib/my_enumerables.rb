module Enumerable
  # Your code goes here
  def my_each(&block)
    return enum_for(:my_each) unless block_given?

    for element in self
      yield element
    end

    self
  end

  def my_each_with_index(&block)
    return enum_for(:my_each_with_index) unless block_given?

    index = 0 
    self.my_each do |element|
      yield element, index 
      index += 1
    end
    
    self
  end

  def my_select(&block)
    return enum_for(:my_select) unless block_given?

    result = []
    self.my_each do |element|
      result << element if yield element
    end

    result
  end

  def my_all?(&block)
    return true unless block_given?

    self.my_each do |element|
      return false unless yield element
    end

    true
  end

  def my_any?(&block)
    return flase unless block_given?

    self.my_each do |element|
      return true if yield element
    end

    false
  end

  def my_count(&block)
    return self.size unless block_given?

    count = 0
    self.my_each do |element|
      count += 1 if yield element
    end

    count
  end

  def my_map(&block)
    return enum_for(:my_map) unless block_given?

    result = []
    self.my_each do |element|
      if block_given?
        result << yield(element)
      else 
        result << element
      end
    end

    result
  end

  def my_none?(&block)
    return true unless block_given?

    self.my_each do |element|
      return false if yield element
    end

    true
  end

  def my_inject(intial = nil)
    array = self.to_a
    accumulator = intial.nil? ? array.shift : intial

    array.my_each do |element|
      accumulator = yield(accumulator, element)
    end

    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  include Enumerable
end
