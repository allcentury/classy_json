module ClassyJSON
  module Utils
    private

    def build_response_attr(resp)
      objs = resp.keys.each_with_object([]) do |key, arr|
        class_name = key.underscore.classify
        klass = find_or_create(class_name)

        if resp[key].is_a? Array
          #instantiate many objects
          resp[key].each { |v| arr << klass.new(v) }
        elsif resp[key].is_a? Hash
          #instantiate one object
          arr << klass.new(resp[key])
        end
      end

      raise ArgumentError, "JSON is a single object, please specify the class to create" if objs.empty?

      objs.size > 1 ? objs : objs.first
    end

    def find_or_create(class_name)
      #searches for known constants
      if ClassyJSON.const_defined?(class_name)
        klass = ClassyJSON.const_get(class_name)
      else
        #if constant does not exist we create it and build
        #dynamic attributes
        klass = ClassyJSON.const_set(class_name, Class.new)
        build_klass(klass)
        klass
      end
    end

    def build_klass(klass)
      klass.class_eval do
        include ClassyJSON
        define_method(:initialize) do |values|
          values.each do |k, v|
            k, v = build_attr_declarations(k, v)
            instance_variable_set("@#{k}", v)
            self.class.send(:attr_reader, k)
          end
        end
      end
    end

    def build_attr_declarations(k, v)
      if v.is_a? Hash #if true build another object
        v = build_response_attr({ k => v})
      elsif v.is_a?(Array) && all_hashes?(v) # if true array of more objects
        v = v.map { |j| build_response_attr(k => j) }.flatten
      end
      v = v.to_i if int?(v)
      k = k.underscore #convert camelcase to underscore

      return k, v
    end

    def int?(val)
      #this converts strings to integers
      # ie "100" => 100
      # ie "ABC" => nil
      # ie "1" => 1
      Integer(val) rescue nil
    end

    def all_hashes?(type)
      type.all? { |j| j.is_a? Hash }
    end

  end
end
