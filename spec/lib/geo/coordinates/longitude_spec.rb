RSpec.describe Geo::Coordinates::Longitude do
  let(:valid_value)   { '-23.459726' }
  let(:invalid_value) { '-190' }

  it_behaves_like 'a coordinate'
end
