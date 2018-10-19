# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'RubocopRules::VERSION' do
  it 'has a version' do
    expect(RubocopRules::VERSION).to_not be_nil
  end
end
