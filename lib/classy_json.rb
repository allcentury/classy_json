require "classy_json/version"
require "classy_json/conversion"
require "classy_json/utils"
require "json"
require "active_support/inflector"

module ClassyJSON
  include Utils
  class << self
    include ClassyJSON

    # Converts the response object into ruby classes
    #
    # @param resp [String]
    # @param key [String, nil]
    # @return [ClassyJSON::Conversion] the object converted into the expected format.
    def convert(resp, key=nil)
      json = JSON.parse(resp)
      validate_parser(json, key)
      json = { key => json} if key

      objs = build_response_attr(json)
      ClassyJSON::Conversion.new(objs)
    end

    private

    def validate_parser(json, key)
      if json.is_a?(Array) && key.nil?
        raise ArgumentError, "JSON is an array, please provide a top level string to describe the array i.e. ClassyJSON.convert('github_jobs_response', 'jobs')"
      end
    end
  end
end
