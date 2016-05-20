shared_examples_for 'a coordinate' do
  it 'has a value' do
    expect(described_class.new(valid_value).value).to eq(valid_value)
  end

  describe '#valid?' do
    it 'returns true if the coordinate value is valid' do
      expect(described_class.new(valid_value).valid?).to be_truthy
    end

    it 'returns false if the coordinate value is not valid' do
      expect(described_class.new(invalid_value).valid?).to be_falsy
    end
  end
end
