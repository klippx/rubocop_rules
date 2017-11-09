require 'spec_helper'

RSpec.describe 'CHANGELOG.md' do
  it 'the latest version is described in changelog' do
    changelog = File.read('CHANGELOG.md')
    latest_version = changelog.match(/^## \[(\d+\.\d+\.\d+)\]/)
    expect(latest_version).to_not be_nil
    expect(latest_version[1]).to eq(RubocopRules::VERSION)
  end
end
