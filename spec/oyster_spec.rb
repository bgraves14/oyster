require 'oyster'

describe Oyster do


  it 'has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it { is_expected.to respond_to(:deduct_amount).with(1).argument }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  describe 'added balance needed' do

    before(:each) do
      subject.top_up(Oyster::BALANCE_LIMIT)
    end

    it 'raises and error when maximum balance is exceeded' do
      expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
    end

    describe '#deduct_amount' do

      it 'can deduct from balance' do
        subject.deduct_amount(1)
        expect(subject.balance).to eq(Oyster::BALANCE_LIMIT - 1)
      end
    end
  end

end
