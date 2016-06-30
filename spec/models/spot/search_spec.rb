RSpec.describe Spot::Search, type: :model do
  specify '#remote_search' do
    results = Spot::Search.new.remote_search
    expect(results).to be_falsy
  end

  specify '#merge_components' do
    instance = Spot::Search.new
    instance.send(:merge_components, { 2 => { a: 1} }, { data: ['uuid' => 2]})
  end

  specify '#find_by_latlng' do
    instance = Spot::Search.new
    instance.send(:find_by_latlng, { components: { 'lat' => 1, 'lon' => 2 }})
  end
end
