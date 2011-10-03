class Checkout
  attr_accessor :total 

  def initialize(rules)
    @rules=rules
    @total=0
    @receipt = Hash.new(0) 
  end

  def scan(items)
    items.each_char do |item|
      return unless @rules.has_key?(item)
      @receipt[item] += 1
      @total += @rules[item].price(@receipt[item])
    end
    @total
  end
end

class Rule

  def initialize(unit_price,special_description = nil)
    @unit_price = unit_price

    if special_description
      special_count, dummy, special_price = special_description.split(' ')
      @special_count = special_count.to_i
      @discount = special_price.to_i - (@special_count - 1) * unit_price
    end
  end

  def discount?(running_count)
    @discount && running_count.remainder(@special_count) == 0
  end

  def price(running_count)
    discount?(running_count) ? @discount : @unit_price
  end
end
