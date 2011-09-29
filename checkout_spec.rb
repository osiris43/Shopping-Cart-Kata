require './Checkout.rb'

describe Checkout do
  subject {Checkout.new(
      'F' => Rule.new(50, '3 for 130'),
      'D' => Rule.new(15),
      'B' => Rule.new(30, '2 for 45'),
      'A' => Rule.new(50)
  )}

  it "prices a D item correctly" do
    subject.scan('D').should == 15
  end 

  it "prices empty cart correctly" do
    subject.scan('').should == 0
  end 

  it "prices an A item correctly" do
    subject.scan('A').should == 50
  end

  it "prices two items correctly" do
    subject.scan('AA').should == 100
  end

  it "prices two items correctly" do
    subject.scan('AB').should == 80
  end

  it "prices special price for one item correctly" do
    subject.scan('FFF').should ==130
  end

  it "prices special price for one item correctly" do
    subject.scan('FFFFFF').should ==260
  end
  
  it "prices special price for multiple items correctly" do
    subject.scan('FFFB').should == 160
  end

  it "prices for multiple specials" do
    subject.scan('FFFBB').should == 175 
  end
end
