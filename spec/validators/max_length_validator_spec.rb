RSpec.describe MetadataPresenter::MaxLengthValidator do
  subject(:validator) do
    described_class.new(page: page, answers: answers, component: component)
  end
  let(:component) { page.components.first }

  describe '#valid?' do
    before do
      validator.valid?
    end

    context 'when answer is blank' do
      let(:answers) { {'full_name' => '' } }
      let(:page) { service.find_page_by_url('/name') }

      it 'returns valid' do
        expect(validator).to be_valid
      end
    end

    context 'when maximum length is invalid' do
      let(:answers) { {'full_name' => 'Gandalf the Grey' } }

      context 'when there is no custom error message' do
        let(:page) { service.find_page_by_url('/name') }

        it 'returns invalid' do
          expect(validator).to_not be_valid
        end

        it 'uses the default error message' do
          expect(page.errors.full_messages).to eq(
            ["Your answer for 'Full name' is too long (10 characters at most)"]
          )
        end
      end

      context 'when there is a custom error message' do
        let(:page) { service.find_page_by_url('/email-address') }
        let(:answers) do
          { 'email_address' => 'gandalf.mithrandir@middleearth.gov.uk' }
        end

        it 'uses the custom error message' do
          expect(page.errors.full_messages).to eq(
            ['Your email address is too long.']
          )
        end
      end
    end

    context 'when maximum length is valid' do
      let(:answers) { {'full_name' => 'Gandalf' } }
      let(:page) { service.find_page_by_url('/name') }

      it 'returns no errors' do
        expect(page.errors.full_messages).to eq([])
      end
    end
  end
end
