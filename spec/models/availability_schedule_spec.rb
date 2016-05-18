describe AvailabilitySchedule do
  it 'should be valid when given valid attributes' do
    expect(build(:availability_schedule)).to be_valid
  end

  describe 'from' do
    it 'should not be less than the lower bound of week days' do
      schedule = build(:availability_schedule, :from_too_small)
      expect(schedule).to have(1).error_on(:from)
    end

    it 'should not be greater than the upper bound of week days' do
      schedule = build(:availability_schedule, :from_too_large)
      expect(schedule).to have(1).error_on(:from)
    end
  end

  describe 'to' do
    it 'should not be less than the lower bound of week days' do
      schedule = build(:availability_schedule, :to_too_small)
      expect(schedule).to have(1).error_on(:to)
    end

    it 'should not be greater than the upper bound of week days' do
      schedule = build(:availability_schedule, :to_too_large)
      expect(schedule).to have(1).error_on(:to)
    end
  end
end
