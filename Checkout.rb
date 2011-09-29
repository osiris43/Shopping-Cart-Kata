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
    @total += special?(item, rule) ? rule.discount : rule.unit_price
  end

  def special?(item, rule)
    rule.special_price && @receipt[item].remainder(rule.special_count) == 0
  end
end

class Rule
  attr_accessor :unit_price, :special_count, :special_price

  def initialize(unit_price,special_description = nil)
    @unit_price = unit_price

    if special_description
      special_count, dummy, special_price = special_description.split(' ')
      @special_count = special_count.to_i
      @special_price = special_price.to_i
    end
  end

  def discount
    @special_price - (@special_count - 1) * @unit_price
  end
end
