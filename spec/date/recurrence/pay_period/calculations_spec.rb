require 'date/recurrence/pay_period'

RSpec.describe Date::Recurrence::PayPeriod::Calculations do
  let(:date) { Date.new(2020,1,1) }
  let(:time) { Time.new(2020,1,1) }
  let(:pay_period_starts) { Date.new(2019,12,22) }
  it "should calculate the beginning of the pay period" do
    expect(date.beginning_of_pay_period).to eq(pay_period_starts)
    expect(time.beginning_of_pay_period).to eq(pay_period_starts)
  end
end
