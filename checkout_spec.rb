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
    subject.scan('A')
    subject.total.should == 50
  end

  it "prices two items correctly" do
    subject.scan('A')
    subject.scan('A')
    subject.total.should == 100
  end

  it "prices two items correctly" do
    subject.scan('A')
    subject.scan('B')
    subject.total.should == 80
  end

  it "prices special price for one item correctly" do
    subject.scan('F')
    subject.scan('F')
    subject.scan('F')

    subject.total.should ==130
  end

  it "prices special price for one item correctly" do
    6.times { subject.scan('F')}
    subject.total.should ==260
  end
  
  it "prices special price for multiple items correctly" do
    subject.scan('F')
    subject.scan('F')
    subject.scan('F')
    subject.scan('B')

    subject.total.should == 160
  end

  it "prices for multiple specials" do
    subject.scan('F')
    subject.scan('F')
    subject.scan('F')
    subject.scan('B')
    subject.scan('B')

    subject.total.should == 175 
  end
end
