require 'date/recurrence/n_daily'

RSpec.describe Date::Recurrence::NDaily do
  let(:recurrence) do
    NDaily.new(
      origin: Date.new(2020,1,1),
      every: { days: 5 },
      on_days: [0,1,3]
    )
  end
end
