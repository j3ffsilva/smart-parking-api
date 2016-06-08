describe PricingSchedule do
  it 'should be valid when given valid attributes' do
    expect(build(:pricing_schedule)).to be_valid
  end

  it 'should have a valid price' do
    schedule = build(:pricing_schedule, :invalid_price)
    expect(schedule).to have(1).error_on(:price)
  end

  describe 'from' do
    it 'should not be less than the lower bound of week days' do
      schedule = build(:pricing_schedule, :from_too_small)
      expect(schedule).to have(1).error_on(:from)
    end

    it 'should not be greater than the upper bound of week days' do
      schedule = build(:pricing_schedule, :from_too_large)
      expect(schedule).to have(1).error_on(:from)
    end
  end

  describe 'to' do
    it 'should not be less than the lower bound of week days' do
      schedule = build(:pricing_schedule, :to_too_small)
      expect(schedule).to have(1).error_on(:to)
    end

    it 'should not be greater than the upper bound of week days' do
      schedule = build(:pricing_schedule, :to_too_large)
      expect(schedule).to have(1).error_on(:to)
    end
  end

  let(:as_schedulable) { build(:pricing_schedule) }
  it_behaves_like 'a schedulable model'
end
