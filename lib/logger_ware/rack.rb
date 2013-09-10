require 'rack'
require 'logger_ware/collector'

module LoggerWare
  class Rack
    include Collector

    @collect_params = COLLECT_PARAMS
    @filter_params  = FILTER_PARAMS
    @replace_with    = REPLACE_WITH
    @filters = PARAM_FILTERS
    @handler = ->(_) {raise 'missing handler, please assign'}
    @error_handler = ->(_) {raise 'missing error_handler, please assign'}

    class << self
      attr_accessor :collect_params, :filter_params, :replace_with, :filters, :handler, :error_handler
    end

    [:collect_params, :filter_params, :replace_with, :filters, :handler, :error_handler].each do |m|
      define_method(m) { |*args| self.class.send(m, *args) }
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      started_at = Time.now.utc

      status, headers, response = @app.call(env)

      handler[{status: status, headers: headers, response: response, started_at: started_at, duration: duration(started_at), data: data(env)}]
      [status, headers, response]

    rescue => exception

      error_handler[{exception: exception, started_at: started_at, duration: duration(started_at), data: data(env)}]
      raise exception
    end

    def data(env)
      collect(env, collect_params, filter_params, filters, replace_with)
    end

    def duration(started_at)
      Time.now.utc - started_at
    end
  end
end
