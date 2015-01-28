require 'spec_helper'

describe ClassyJSON do
  describe 'objects' do
    let(:objs) { ClassyJSON.convert(fixture("twitter.json").read) }
    it 'with json object' do
      expect(objs.result).to be_a ClassyJSON::Result
      expect(objs.query).to be_a ClassyJSON::Query
    end
    it 'works with nested json' do
      expect(objs.query.params).to be_a ClassyJSON::Param
    end
  end
  describe 'arrays' do
    context 'valid' do
      let(:objs) { ClassyJSON.convert(fixture("github-jobs.json").read, "jobs") }
      it 'with json array' do
        expect(objs.jobs).to be_a Array
        expect(objs.jobs.first).to be_a ClassyJSON::Job
      end
    end
    context 'invalid' do
      it 'with json array' do
        expect { ClassyJSON.convert(fixture("github-jobs.json").read) }.
          to raise_error(ArgumentError).with_message("JSON is an array, please provide a top level string to describe the array i.e. ClassyJSON.convert('github_jobs_response', 'jobs')")
      end
    end
  end
  describe 'object' do
    it 'raises an error' do
      expect { ClassyJSON.convert(fixture("github-job.json").read) }.
        to raise_error(ArgumentError).with_message("JSON is a single object, please specify the class to create")
    end
    it 'works' do
      resp = ClassyJSON.convert(fixture("github-job.json").read, "job")
      expect(resp.job).to be_a ClassyJSON::Job
    end
  end
  describe 'nested objects' do
    let(:objs) { ClassyJSON.convert(fixture("weather.json").read) }
    it 'wunderground' do
      expect(objs).to be_a ClassyJSON::Conversion
    end
  end
end
