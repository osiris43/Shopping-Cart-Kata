class Checkout
  attr_accessor :total 

  def initialize(rules)
    @rules=rules
    @total=0
    @receipt = Hash.new(0) 
  end

  def scan(item)
    return unless @rules.has_key?(item)
    @receipt[item] += 1
    rule = @rules[item]
    special?(item, rule) ? add_special(item, rule) : @total += rule.unit_price
  end

  def special?(item, rule)
    return false unless rule.special_price
    @receipt[item].remainder(rule.special_count) == 0
  end

  def add_special(item, rule)
    @total += rule.special_price - (rule.special_count - 1) * rule.unit_price
  end
end

class Rule
  attr_accessor :unit_price, :special_count, :special_price
  def initialize(unit_price,special_description)
    @unit_price = unit_price

    if !special_description.empty?
      @special_count = special_description.split(' ')[0].to_i
      @special_price = special_description.split(' ')[2].to_i
    end
  end
end
