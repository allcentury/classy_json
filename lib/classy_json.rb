require "classy_json/version"
require "classy_json/conversion"
require "classy_json/ostruct_conversion"
require "classy_json/utils"
require "json"
require "active_support/inflector"

module ClassyJSON
  include Utils
  class << self
    include ClassyJSON

    def convert(resp, key=nil)
      json = JSON.parse(resp)

      # if JSON starts as an array, we need a top level key
      validate_parser(json, key)

      # set top level key
      json = { key => json} if key

      # build objects
      objs = build_response_attr(json)
      ClassyJSON::Conversion.new(objs)
    end

    def convert_with_ostruct(resp, key=nil)
      json = JSON.parse(resp)
      ClassyJSON::OStructConversion.new(json)
    end

    private

    def validate_parser(json, key)
      if json.is_a?(Array) && key.nil?
        raise ArgumentError, "JSON is an array, please provide a top level string to describe the array i.e. ClassyJSON.convert('github_jobs_response', 'jobs')"
      end
    end
  end
end
