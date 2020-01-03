RSpec.describe "every" do
  let(:recurrence) do |args|
    Date::Recurrence.new(args.metadata.slice(:every, :interval))
  end
  subject { recurrence.frequency }

  context "day", every: :day do
    it { is_expected.to eq({days: 1}) }
  end
  context "other day", every: :day, interval: 2 do
    it { is_expected.to eq({days: 2}) }
  end
  context "week", every: :week do
    it { is_expected.to eq({days: 7}) }
  end
  context "other week", every: :week, interval: 2 do
    it { is_expected.to eq({days: 14}) }
  end
  context "month", every: :month do
    it { is_expected.to eq({months: 1}) }
  end
  context "other month", every: :month, interval: 2 do
    it { is_expected.to eq({months: 2}) }
  end
  context "year", every: :year do
    it { is_expected.to eq({years: 1}) }
  end
  context "other year", every: :year, interval: 2 do
    it { is_expected.to eq({years: 2}) }
  end
end
