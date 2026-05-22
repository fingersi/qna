RSpec.shared_examples 'Linkable' do
  context 'links returns' do
      it 'returns all links' do
        expect(json_object['links'].size).to eq entity.size
      end

    it 'returns right attributes for link' do
      check_attrs(json_object['links'].first, entity.first, %w[title url created_at updated_at])
    end
  end
end