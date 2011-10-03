require './Checkout.rb'

describe Checkout do
  subject {Checkout.new(
      'F' => Rule.new(50, '3 for 130'),
      'D' => Rule.new(15),
      'B' => Rule.new(30, '2 for 45'),
      'A' => Rule.new(50)
  )}

  [
    ["prices empty cart correctly",                       '',       0],
    ["prices a D item correctly",                         'D',      15],
    ["prices an A item correctly",                        'A',      50],
    ["prices two items correctly",                        'AA',     100],
    ["prices two items correctly",                        'AB',     80],
    ["prices special price for one item correctly",       'FFF',    130],
    ["prices special price for one item correctly",       'FFFFFF', 260],
    ["prices special price for multiple items correctly", 'FFFB',   160],
    ["prices for multiple specials",                      'FFFBB',  175],
  ].each do |description, scan, expected_total|
    it description do
      subject.scan(scan).should == expected_total
    end
  end
end
