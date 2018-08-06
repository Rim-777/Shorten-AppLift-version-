require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should have_many(:clicks).class_name('Link::Click').dependent(:destroy) }
  it { should validate_presence_of(:url) }

  describe '.validations' do
    context 'valid attributes' do
      let(:link) { build(:link, url: 'https://short-urls') }

      it 'saves a new link in the database' do
        expect { link.save }.to change(Link, :count).by(1)
      end
    end

    context 'the url is blank' do
      let(:link) { build(:link, url: '') }

      it 'does not save a new link in the database' do
        expect { link.save }.to_not change(Link, :count)
      end
    end
  end

  describe '#add_click' do
    let!(:link) { create(:link, url: 'https://short-urls') }

    it 'saves a new click in the database' do
      expect { link.add_click }.to change(Link::Click, :count).by(1)
    end

    it 'adds a click for the link as a relation' do
      expect { link.add_click }.to change(link.clicks, :count).by(1)
    end
  end

  describe '#new_shortcode' do
    let!(:link) { create(:link, url: 'https://short-urls') }
    it 'receives generate method for ShortcodeGenerator class with given arguments' do
      expect(ShortcodeGenerator).to receive(:generate).with(6)
      link.send(:new_shortcode)
    end
  end

  describe 'callback before_validations #set_shortcode' do
    let!(:link) { build(:link, url: 'https://short-urls') }

    it 'generates a valid shortcode for the given link' do
      link.save
      expect(link.shortcode).to be_present
    end
  end
end
