require_relative 'request'
require 'mechanize'
require 'json'


class Utils
    module MechanizeUtils

        def init_mechanize(options = {})
            @utils_mechanize_options = options
            @logs = []
            @debug = false
            @list_time = []
            @mechanize = Mechanize.new do |a|
                a.user_agent_alias = ['Windows Mozilla', 'Windows IE 9', 'Windows IE 10', 'Windows IE 11', 'Windows Firefox', 'Mac Firefox', 'Linux Firefox'].sample
                a.verify_mode = OpenSSL::SSL::VERIFY_NONE
                a.redirect_ok = :all
            end
        end

        def post(request)
            @requests = request
            check_limits
            page = @mechanize.post(request.url, request.params, request.options)
            page
        end

        def get(request)
            @requests = request
            check_limits
            page = @mechanize.get(request.url, request.params, nil, request.options)
            page
        end

        def check_limits
            return if !self.class.respond_to?(:limits)
            return if config_limits.blank?

            if config_limits.url_matches.any?{|url| @request.url.match url}
                requests_in_limited_time = @list_time.select{|time| time >= Time.now - config_limits.time }
                unless requests_in_limited_time.count < config_limits.limit
                    time_to_sleep = ( Time.now - requests_in_limited_time.sort.first ).seconds
                    p "Taking a nap - #{time_to_sleep}"
                    sleep time_to_sleep
                end
                # ping_proxy if respond_to?(:ping_proxy)
                @list_time << Time.now
            end
        end

    end

end
