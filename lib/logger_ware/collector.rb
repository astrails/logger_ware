require 'logger_ware/filter'

module LoggerWare
  module Collector
    include Filter

    COLLECT_PARAMS = {
      request_path:  'PATH_INFO',
      method:        'REQUEST_METHOD',
      request_uri:   'REQUEST_URI',
      user_agent:    'HTTP_USER_AGENT',
      http_accept:   'HTTP_ACCEPT',
      rack_session:  "rack.session",
      request_ip:    'REMOTE_ADDR',
      request_ip_fw: 'HTTP_X_FORWARDED_FOR',
      referer:       'HTTP_REFERER',
    }
    FILTER_PARAMS = {
      request_parameters: 'action_controller.request.request_parameters',
      path_parameters:    'action_controller.request.path_parameters',
      query_parameters:   'action_controller.request.query_parameters',
    }

    PARAM_FILTERS = [/password/]

    def _collect env, keys, filters = nil, replace_with = nil
      keys.each_with_object({}) do |(k,v), res|
        next unless env.has_key?(v)
        v = env[v]
        v = filter(v, filters, replace_with) if filters
        res[k] = v
      end
    end

    def collect env, collect_params = COLLECT_PARAMS, filter_params = FILTER_PARAMS, filters = PARAM_FILTERS, replace_with = Filter::REPLACE_WITH
      _collect(env, collect_params).merge(_collect(env, filter_params, filters, replace_with))
    end

  end
end
