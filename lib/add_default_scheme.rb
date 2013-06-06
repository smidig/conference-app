module AddDefaultScheme
  class ActiveRecord::Base
    private

    def self.add_default_scheme(*args)
      fields = args.select do |arg|
        !arg.is_a?(Hash)
      end

      options = { :default_scheme => 'http' }

      args.each do |arg|
        options.merge!(arg) if arg.is_a?(Hash)
      end

      fields.each do |field|
        define_method "#{field}=" do |value|
          begin
            if URI.parse(value).scheme.nil?
              super("#{options[:default_scheme]}://#{value}")
            else
              super(value)
            end
          rescue
            super(value)
          end
        end
      end
    end
  end
end

