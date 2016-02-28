class Oyster

  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :in_journey, :journey
  attr_accessor :entry_station, :exit_station

  def initialize
    @balance = 0
    @in_journey = false
    @journey = {}
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct_amount(amount)
    @balance -= amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    @entry_station = entry_station
    fail 'You must have a minimum of 1$ to touch in!' if @balance < MINIMUM_BALANCE
    @in_journey = true
    @journey[:entry_station] = @entry_station
  end

  def touch_out(exit_station)
    deduct_amount(MINIMUM_BALANCE)
    @exit_station = exit_station
    @entry_station = nil
    @journey[:exit_station] = @exit_station
  end

  def journeys
    @journey
  end

  private :deduct_amount

end
