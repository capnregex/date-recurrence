RSpec.describe Date::Recurrence do
  let(:today) { Date.today }
  let(:newyears) { Date.new(2020,1,1) }
  let(:default_origin) { Date.new(2017, 1, 1) }
  let(:origin) { newyears.beginning_of_week(:sunday) }
  let(:frequency) { { days: 14 } }
  let(:starting) { newyears }
  let(:ending) { Date.new(2020,3,1) }
  let(:days) { [0,1,3] }
  let(:options) do
    { 
      origin: origin, 
      frequency: frequency, 
      on: days, 
      starting: starting, 
      ending: ending 
    } 
  end
  let(:recurrence) { Date::Recurrence.new(options) }
  subject { recurrence }

  context "class" do
    subject { described_class }
    it { expect(subject.origin).to eq(default_origin) }
    it { expect(subject.frequency).to eq(:biweekly) }
    it { expect(subject.on).to be_nil }
  end

  context "instance" do
    let(:options) do
      { 
        origin: origin, 
        frequency: frequency, 
        on: days, 
        starting: starting, 
        ending: ending 
      } 
    end
    it { expect(subject.origin).to eq(origin) }
    it { expect(subject.frequency).to eq(frequency) }
    it { expect(subject.on).to eq(days) }
    it { expect(subject.options).to eq({}) }
    it { expect(subject.starting).to eq(starting) }
    it { expect(subject.ending).to eq(ending) }
    it ".days_to_origin" do
      expect(recurrence.days_to_origin(origin.advance(days: 75))).to eq(75)
    end
    it ".days_to_period_start" do
      binding.pry
      expect(recurrence.days_to_period_start(newyears)).to eq(75)
    end
    context ".period" do
      let(:period) { recurrence.period_for(starting) }
      it { expect(period).to be_a(Date::Recurrence::Period) }
      it { expect(period.recurrence).to be(recurrence) }
      it { expect(period.starts).to eq(starting) }
    end
  end

end
