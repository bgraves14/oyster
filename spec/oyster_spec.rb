require 'oyster'

describe Oyster do

  let(:entry_station){double :station}
  let(:exit_station){double :station}
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'has an empty journey log' do
    expect(subject.journeys).to be_empty
  end


  it 'will only let people touch in if balance is minimum of $1' do
    expect{ subject.touch_in(entry_station) }.to raise_error 'You must have a minimum of 1$ to touch in!'
  end


  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  describe 'in journey' do

    before(:each) do
      subject.top_up(Oyster::BALANCE_LIMIT)
      subject.touch_in(entry_station)
    end

    it 'can touch in' do
      expect(subject).to be_in_journey
    end

    it 'can touch out' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it 'will charge when you touch out' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oyster::MINIMUM_BALANCE)
    end

    it 'stores a entry station' do
      expect(subject.entry_station).to eq entry_station
    end

    it 'stores a exit station' do
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    it 'stores a journey' do
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end

    it 'raises and error when maximum balance is exceeded' do
      expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
    end
  end

end
