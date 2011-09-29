class Checkout
  attr_accessor :total 

  def initialize(rules)
    @rules=rules
    @total=0
    @receipt = Hash.new(0) 
  end

  def scan(item)
    if !@rules.has_key?(item)
      return
    else
      @receipt[item] += 1
      
      rule = @rules[item]

      if check_special?(item, rule)
        add_special(item, rule)
      else
        @total += rule.unit_price
      end
    end
  end

  def check_special?(item, rule)
    if rule.special_price.nil?
      return false
    end

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
