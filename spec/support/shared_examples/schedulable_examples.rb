shared_examples_for 'a schedulable model' do
  specify '#human_description' do
    expect(as_schedulable.human_description).to be_a(String)
  end

  specify '#formatted_time' do
    time = Time.parse('2016-01-01 23:32:31')
    expect(as_schedulable.formatted_time(time)).to eq('23:32:31')
  end

  specify '#formatted_weekday' do
    expect(as_schedulable.formatted_weekday(1)).to eq('Mon')
  end
end
