require_relative 'request'

module UtilsRequest
    module ClassMethods
        def request(description, url, options = {}, &block)
            define_method("#{description}_request") do
                request = Request.new
                request.description = description
                request.params = instance_eval(&block) if block
                request.url = url
                request.options = options
                request
            end
        end

        def dynamic_request(description, url=nil, options = {}, &block)
            define_method("#{description}_request") do
                request = Request.new
                request.description = description
                result = instance_eval(&block) if block
                request.params = result.fetch(:params, {})
                request.url = result.fetch(:url, url)
                request.options = result.fetch(:options, options)
                request
            end
        end

        def default(namespace = nil, &block)
            define_method "default_#{namespace}" do
                instance_eval("@default_#{namespace} ||= #{instance_eval(&block)}") if block
            end
        end
    end

    module InstanceMethods

        def default(namespace = nil)
            method("default_#{namespace}").call
        end
    end

    def self.included(receiver)
        receiver.extend         ClassMethods
        receiver.send :include, InstanceMethods
    end
end