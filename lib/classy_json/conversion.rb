module ClassyJSON
  class Conversion
    def initialize(options)
      options = obj_struct_build(options)
    end

    private

    def group_by_class(options)
      #this method groups together objects by class type
      objs = options.group_by { |v| v.class }
      objs.each_with_object({}) do |(k, v), response|
        if v.count > 1
          response[k.to_s.underscore.pluralize] = v
        else
          response[k.to_s.underscore] = v.first
        end
      end
    end

    def obj_struct_build(options)
      #this method determines if a single object was sent to Response or many.
      # we use group_by_class in case of many otherwise we return the lone object
      if options.is_a? Array
        vals = group_by_class(options)
        vals.each { |k, v| set_attrs(k, v) }
      elsif options.is_a? Hash
        options.each { |k, v| set_attrs(k, v) } #multiple objects already built
      else
        klass = options.class.to_s.underscore
        set_attrs(klass, options)
      end
    end

    def set_attrs(k, v)
      k = k.split('/').last
      instance_variable_set("@#{k}", v)
      self.class.send(:attr_reader, k)
    end
  end
end
