require 'oyster'

describe Oyster do

  it 'has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'raises and error when maximum balance is exceeded' do
    maximum_balance = Oyster::BALANCE_LIMIT
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  describe '#deduct_amount' do
    it { is_expected.to respond_to(:deduct_amount).with(1).argument }

    it 'can deduct from balance' do
      subject.top_up(5)
      subject.deduct_amount(1)
      expect(subject.balance).to eq(4)
    end
  end

end
