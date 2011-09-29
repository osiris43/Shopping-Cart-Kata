load 'Checkout.rb'

describe Checkout do
  before(:each) do
    setup_rules
  end

  it "prices a D item correctly" do
    co = Checkout.new(@rules)

    co.scan('D')
    co.total.should == 15
  end 

  it "prices empty cart correctly" do
    co = Checkout.new(@rules)

    co.scan('')
    co.total.should == 0
  end 

  it "prices an A item correctly" do
    co = Checkout.new(@rules)

    co.scan('A')
    co.total.should == 50
  end

  it "prices two items correctly" do
    co = Checkout.new(@rules)

    co.scan('A')
    co.scan('A')
    co.total.should == 100
  end

  it "prices two items correctly" do
    co = Checkout.new(@rules)

    co.scan('A')
    co.scan('B')
    co.total.should == 80
  end

  it "prices special price for one item correctly" do
    co = Checkout.new(@rules)

    co.scan('F')
    co.scan('F')
    co.scan('F')

    co.total.should ==130
  end

  it "prices special price for one item correctly" do
    co = Checkout.new(@rules)
    
    6.times do
      co.scan('F')
    end
    co.total.should ==260
  end
  
  it "prices special price for multiple items correctly" do
    co = Checkout.new(@rules)

    co.scan('F')
    co.scan('F')
    co.scan('F')
    co.scan('B')

    co.total.should == 160
  end

  it "prices for multiple specials" do
    co = Checkout.new(@rules)

    co.scan('F')
    co.scan('F')
    co.scan('F')
    co.scan('B')
    co.scan('B')

    co.total.should == 175 
  end


  def setup_rules
    @rules = {}
    @rules['F'] = Rule.new(50,'3 for 130')
    @rules['D'] = Rule.new(15, '' )
    @rules['B'] = Rule.new(30, '2 for 45')
    @rules['A'] = Rule.new(50, "")
  end

end
