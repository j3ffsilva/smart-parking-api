RSpec.describe Geo::Coordinates::Latitude do
  let(:valid_value)   { '-23.459726' }
  let(:invalid_value) { '-100' }

  it_behaves_like 'a coordinate'
end
