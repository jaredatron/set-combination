require File.expand_path("../combination/version", __FILE__)

class Set::Combination < Set

  InvalidDimentionError = Class.new(StandardError)

  class << self
    alias_method :[], :new
  end

  def initialize *dimentions
    @dimentions = dimentions.clone

    unless dimentions.all?{|dimention| dimention.respond_to? :to_a }
      raise Set::Combination::InvalidDimentionError.new "all dimentions must respond to to_a"
    end

    members = dimentions.map(&:to_a).flatten
    if members != members.uniq
      raise Set::Combination::InvalidDimentionError.new "all members in a combination must be uniq"
    end

    combinations = dimentions.shift.to_a.map{|v| Set[v] }.to_set
    combinations = dimentions.inject(combinations){ |combinations, dimention|
      combinations.inject([]){|new_combinations, combination|
        (new_combinations + dimention.to_a.map{ |member| combination + Set[member] }).to_set
      }
    }
    super combinations
  end

  attr_reader :dimentions

  def * dimention
    dimentions = dimention.respond_to?(:dimentions) ? dimention.dimentions : [dimention]
    self.class.new *(self.dimentions + dimentions)
  end

  def inspect
    %(#<#{self.class} #{to_a.map(&:inspect)*', '}>)
  end

end

class Set

  def * set
    Set::Combination[self] * set
  end

end


# run the tests if it's this file that was executed
eval <<-RUBY, nil, $0, __LINE__+4 if $0 == __FILE__

require 'test/unit'

class SetCombinationTestCase < Test::Unit::TestCase
  def test_combining

    d1 = Set[:open, :closed]
    d2 = Set[:on,   :off]
    d3 = Set[:full, :empty]

    assert_equal(
      Set[Set[:open, :on], Set[:open, :off], Set[:closed, :on], Set[:closed, :off]],
      d1 * d2
    )

    assert_equal(
      Set[Set[:open, :full], Set[:open, :empty], Set[:closed, :full], Set[:closed, :empty]],
      d1 * d3
    )

    assert_equal(
      Set[
        Set[:open,   :on,  :full ],
        Set[:open,   :on,  :empty],
        Set[:open,   :off, :full ],
        Set[:open,   :off, :empty],
        Set[:closed, :on,  :full ],
        Set[:closed, :on,  :empty],
        Set[:closed, :off, :full ],
        Set[:closed, :off, :empty]
      ],
      d1 * d2 * d3
    )

    assert_equal(
      "all members in a combination must be uniq",
      (begin
        d1 * d1
      rescue Set::Combination::InvalidDimentionError => e
        e.message
      end)
    )

    assert_equal(
      "all dimentions must respond to to_a",
      (begin
        d1 * 10
      rescue Set::Combination::InvalidDimentionError => e
        e.message
      end)
    )

  end
end

RUBY
