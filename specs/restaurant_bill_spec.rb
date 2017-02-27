require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/restaurant_bill'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

describe RestaurantBill do

  before do
    @my_bill = RestaurantBill.new
  end

  it "A bill is created with an empty ordered_items" do
    @my_bill.ordered_items.must_be_instance_of Array
    @my_bill.ordered_items.length.must_equal 0
  end

  it "Should add item to ordered_items" do
    @my_bill.order_item("pizza", 10)
    @my_bill.ordered_items.length.must_equal 1
  end

  it "Should add multiple items to ordered items" do
    3.times do
      @my_bill.order_item("pizza", 10)
    end

    @my_bill.ordered_items.length.must_equal 3
  end

  it "Should return total of all items plus tax" do
    3.times do
      @my_bill.order_item("pizza", 10)
    end

    @my_bill.bill_with_tax.must_equal 32.7
  end

  it "Should allow user to add a tip" do
    @my_bill.order_item("pizza", 10)

    @my_bill.tip(20).must_equal 13.08
  end

  it "Should raise an argument error if tip is not positive" do
    @my_bill.order_item("pizza", 10)

    proc {@my_bill.tip(-20)}.must_raise ArgumentError
  end

  it "Should return final bill" do
    @my_bill.order_item("pizza", 10)
    @my_bill.tip(20)
    @my_bill.final_bill.must_equal "SUBTOTAL: 10.0\nTAX: 0.9\nTIP: 2.18\nTOTAL: 13.08"
  end

end
