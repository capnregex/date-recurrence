require 'date/recurrence/pay_period'

RSpec.describe Date::Recurrence::PayPeriod::Calculations do
  let(:date) { Date.new(2020,1,1) }
  let(:time) { Time.new(2020,1,1) }
  let(:pay_period_starts) { Date.new(2019,12,22) }
  let(:pay_period_ends) { Date.new(2020,1,4) }
  let(:next_pay_period_starts) { Date.new(2020,1,5) }
  let(:prev_pay_period_starts) { Date.new(2019,12,8) }

  it "should calculate the beginning of the pay period" do
    expect(date.beginning_of_pay_period).to eq(pay_period_starts)
    expect(time.beginning_of_pay_period.to_date).to eq(pay_period_starts)
  end

  it "should calculate the ending of the pay period" do
    expect(date.ending_of_pay_period).to eq(pay_period_ends)
    expect(time.ending_of_pay_period.to_date).to eq(pay_period_ends)
  end

  it "should calculate the starting of the next pay period" do
    expect(date.next_pay_period_start).to eq(next_pay_period_starts)
    expect(time.next_pay_period_start.to_date).to eq(next_pay_period_starts)
  end

  context "pay_period" do
    let(:payperiod) { date.pay_period }
    it ".starts" do
      expect(payperiod.starts).to eq(pay_period_starts)
    end
    it ".ends" do
      expect(payperiod.ends).to eq(pay_period_ends)
    end
    it ".range" do
      expect(payperiod.range).to eq(pay_period_starts..pay_period_ends)
    end
    it ".day" do
      expect(payperiod.day(0)).to eq(pay_period_starts)
      expect(payperiod.day(13)).to eq(pay_period_ends)
      expect(payperiod.day(-14)).to eq(pay_period_starts)
      expect(payperiod.day(-1)).to eq(pay_period_ends)
      expect(payperiod.day(10)).to eq(date)
    end
    it ".cover?" do
      expect(payperiod.cover? date).to be_truthy
      expect(payperiod.cover? pay_period_starts).to be_truthy
      expect(payperiod.cover? pay_period_ends).to be_truthy
      expect(payperiod.cover? next_pay_period_starts).to be_falsey
    end
    context ".days" do
      let(:days) { payperiod.days }
      it { expect(days.size).to eq(14) }
      it { expect(days.first).to eq(pay_period_starts) }
      it { expect(days.last).to eq(pay_period_ends) }
      it { expect(days).to include(date) }
    end
    context ".next" do
      let(:next_pay_period) { payperiod.next }
      it ".starts" do
        expect(next_pay_period.starts).to eq(next_pay_period_starts)
      end
    end
    context ".prev" do
      let(:prev) { payperiod.prev }
      it ".starts" do
        expect(prev.starts).to eq(prev_pay_period_starts)
      end
    end
  end
end
