module ClassyJSON
  class OStructConversion
    def initialize(json)

      json.keys.each do |k|
        instance_variable_set("@#{k}", build_ostructs(json[k]))
        self.class.send(:attr_reader, k)
      end

    end

    private

    def build_ostructs(a)
      struct = OpenStruct.new
      a.each do |k, v|
        if v.is_a? Hash
          struct[k] = build_ostructs(v)
        elsif v.is_a? Array
          sub_results = []
          v.each do |sub_v|
            sub_results << build_ostructs(sub_v)
          end
          return sub_results
        else
          return OpenStruct.new(a)
        end
      end
      struct
    end
  end

end
