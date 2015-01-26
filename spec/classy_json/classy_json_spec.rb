require 'spec_helper'

describe ClassyJSON do
  let(:objs) { ClassyJSON.convert(fixture("twitter.json").read) }
  it 'with json' do
    expect(objs.result).to be_a Result
    expect(objs.query).to be_a Query
  end
  it 'works with nested json' do
    expect(objs.query.params).to be_a Param
  end
end
