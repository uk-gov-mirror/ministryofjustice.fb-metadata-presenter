RSpec.describe MetadataPresenter::Component do
  subject(:component) { described_class.new(attributes) }

  describe '#to_partial_path' do
    let(:attributes) { { '_type' => 'email' } }

    it 'returns type' do
      expect(component.to_partial_path).to eq(
        'metadata_presenter/component/email'
      )
    end
  end

  describe '#items' do
    let(:component) do
      service.find_page_by_url('do-you-like-star-wars').components.first
    end

    it 'returns an array of openstruct component item objects' do
      expect(component.items).to be_an(Array)
      expect(component.items.size).to eq(2)
    end

    it 'contains objects that respond to the necessary properties' do
      component.items.each do |item|
        expect(item).to respond_to(:id)
        expect(item).to respond_to(:name)
        expect(item).to respond_to(:description)
      end
    end
  end

  describe '#humanised_title' do
    context 'when the component has a label' do
      let(:component) do
        service.find_page_by_url('name').components.first
      end

      it 'returns the label value' do
        expect(component.humanised_title).to eq('Full name')
      end
    end

    context 'when the component has a legend' do
      let(:component) do
        service.find_page_by_url('do-you-like-star-wars').components.first
      end

      it 'returns the legend value' do
        expect(component.humanised_title).to eq('Do you like Star Wars?')
      end
    end
  end

  describe '#content?' do
    context 'when type is content' do
      it 'returns true' do
        component = described_class.new(_type: 'content')
        expect(component.content?).to be_truthy
      end
    end

    context 'when type is not content' do
      it 'returns false' do
        component = described_class.new({})
        expect(component.content?).to be_falsey
      end
    end
  end
end
