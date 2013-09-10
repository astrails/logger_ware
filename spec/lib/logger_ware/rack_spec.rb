require 'spec_helper'

describe LoggerWare::Rack do
  class App
    def call(env)
      [200, {a: 'b'}, 'ok']
    end
  end

  class ErrApp
    def call(env)
      raise 'foo'
    end
  end

  it 'should allow setting filters' do
    LoggerWare::Rack.filters.should == [/password/]
    LoggerWare::Rack.filters << 'qwe'
    LoggerWare::Rack.filters.should == [/password/, 'qwe']
  end

  it 'should call handler' do
    opts = nil
    LoggerWare::Rack.handler = ->(args) {opts = args}
    LoggerWare::Rack.new(App.new).call({}).should == [200, {a: 'b'}, 'ok']
    opts[:status].should == 200
    opts[:response].should == 'ok'
    opts.keys.should == [:status, :headers, :response, :started_at, :duration, :data]
  end

  it 'should call error handler' do
    opts = nil
    LoggerWare::Rack.handler = ->(args) {opts = args}
    err = nil
    LoggerWare::Rack.error_handler = ->(args) {err = args}
    -> {
      LoggerWare::Rack.new(ErrApp.new).call({})
    }.should raise_error('foo')
    err[:exception].to_s.should == 'foo'
  end
end
