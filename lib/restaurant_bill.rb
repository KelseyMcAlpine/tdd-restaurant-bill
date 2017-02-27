class RestaurantBill
  attr_reader :ordered_items, :total_pre_tax, :tax, :tip, :final_bill

  def initialize
    @ordered_items = []
    @total_pre_tax = 0
    @tax = 0
    @tip = 0
    @final_bill = 0
  end

  def order_item(item, cost)
    @ordered_items << [item, cost]
  end

  def bill_with_tax
    @ordered_items.each do |item|
    @total_pre_tax += item[1]
    end

    @tax = @total_pre_tax * 0.09
    @final_bill = @total_pre_tax + @tax
    return @final_bill
  end

  def tip(percent)
    @tip = bill_with_tax * (percent.to_f / 100)
    @final_bill += @tip
    return @final_bill
  end

  def final_bill
    return "SUBTOTAL: #{@total_pre_tax.round(2)}\nTAX: #{@tax.round(2)}\nTIP: #{@tip.round(2)}\nTOTAL: #{@final_bill.round(2)}"
  end


end
