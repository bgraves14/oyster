class Oyster

  BALANCE_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct_amount(amount)
    @balance -= amount
  end

end
