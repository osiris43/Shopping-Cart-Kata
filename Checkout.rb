class Checkout
  
  def initialize(rules)
    @rules=rules
    @total=0
    @receipt = {}
  end

  def scan(item)
    if !@rules.has_key?(item)
      return
    else
      if !@receipt.has_key?(item)
        @receipt[item] = 0
      end

      @receipt[item] += 1
      
      rule = @rules[item]

      if check_special?(item, rule)
        add_special(item, rule)
      else
        @total += rule.unit_price
      end
    end
  end

  def total
    @total
  end

  def check_special?(item, rule)
    if rule.special_price.empty?
      return
    end

    special_count = rule.special_price.split(' ')[0].to_i
    special_price = rule.special_price.split(' ')[2].to_i
    
    @receipt[item].remainder(special_count) == 0
    
  end

  def add_special(item, rule)
    special_count = rule.special_price.split(' ')[0].to_i
    special_price = rule.special_price.split(' ')[2].to_i

    @total += special_price - (special_count- 1) * rule.unit_price
  end
end

class Rule

  def initialize(unit_price,special_price)
    @unit_price = unit_price
    @special_price=special_price
  end

  def unit_price
    @unit_price
  end

  def special_price
    @special_price
  end
end
