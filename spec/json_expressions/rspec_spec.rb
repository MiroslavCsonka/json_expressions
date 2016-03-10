require 'spec_helper'
require 'json_expressions'
require 'json_expressions/rspec'

describe RSpec do
  it "defines wildcard_matcher" do
    expect(wildcard_matcher.object_id).to equal ::JsonExpressions::WILDCARD_MATCHER.object_id
  end
end