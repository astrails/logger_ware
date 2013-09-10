require 'spec_helper'

describe LoggerWare::Filter do
  include LoggerWare::Filter

  describe :match? do
    it 'should NOT match nil filter' do
      match?('foo', nil).should == false
    end

    describe 'string' do
      it 'should match string filter' do
        match?('foo', 'foo').should == true
      end

      it 'should match symbol filter' do
        match?('foo', :foo).should == true
      end

      it 'should match regexp filter' do
        match?('foo', /o/).should == true
      end
    end

    describe :symbol do
      it 'should match string filter' do
        match?(:foo, 'foo').should == true
      end

      it 'should match symbol filter' do
        match?(:foo, :foo).should == true
      end

      it 'should match regexp filter' do
        match?(:foo, /o/).should == true
      end
    end
  end

  describe :filter? do
    it 'should return arg when filters are empty' do
      filter?('foo', []).should == false
    end

    it 'should filter out param by string' do
      filter?('foo', ['foo']).should == true
    end

    it 'should filter out symbol param by string' do
      filter?(:foo, ['foo']).should == true
    end

    it 'should filter out param by symbol' do
      filter?('foo', [:foo]).should == true
    end

    it 'should filter out param by regexp' do
      filter?('foo', [/fo/]).should == true
    end

    it 'should filter out symbol param by regexp' do
      filter?(:foo, [/fo/]).should == true
    end
  end

  describe :filter do
    it 'should return params on empty filters' do
      filter({foo: 123}, []).should == {foo: 123}
    end

    it 'should filter 1st level keys' do
      filter({foo: 123, bar: 456}, [:foo]).should == {foo: '[FILTERED]', bar: 456}
    end

    it 'should filter 2nd level keys' do
      filter({foo: 123, bar: 456, baz: {ooo: 1}}, [/o/]).should == {foo: '[FILTERED]', bar: 456, baz: {ooo: '[FILTERED]'}}
    end

    it 'should use supplied dummy' do
      filter({foo: 123}, [:foo], 'X').should == {foo: 'X'}
    end
  end
end
