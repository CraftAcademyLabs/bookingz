require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#application_name' do
    it 'returns the default application name' do
      expect(helper.application_name).to eq 'Bookingz'
    end
  end

  describe '#copyright_message' do
    it 'returns the default copyright_message' do
      expect(helper.copyright_message).to eq 'Copyright Craft Academy Labs © 2016'
    end
  end

  describe '#callout' do
    it 'returns \'success\' on \'success\'' do
      expect(helper.callout('success')).to eq 'success'
    end
    it 'returns \'warning\' on \'warning\'' do
      expect(helper.callout('warning')).to eq 'warning'
    end
    it 'returns \'alert\' on \'alert\'' do
      expect(helper.callout('alert')).to eq 'alert'
    end
    it 'returns \'primary\' on \'notice\'' do
      expect(helper.callout('notice')).to eq 'primary'
    end
  end

  describe '#parsing' do
    it 'returns a HTML description from markdown text' do
      expect(helper.markdown_parser('app/views/markdown/test.md').gsub("\n","")).to eq '<p>Test for the Markdown parsing</p>'
    end
  end


end
