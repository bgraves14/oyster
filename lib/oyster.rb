class Oyster

  BALANCE_LIMIT = 90

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct_amount(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
