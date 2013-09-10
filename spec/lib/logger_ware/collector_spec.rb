require 'spec_helper'

describe LoggerWare::Collector do
  include LoggerWare::Collector

  E = {
    'A' => 'a',
    'B' => {'C' => 'c', 'D' => 'd'},
    'F' => false,
    'N' => nil,
  }

  describe :collect do
    it 'should return empty hash when no params match' do
      collect(E).should == {}
    end

    it 'should collect params' do
      collect(E, {a: 'A'}).should == {a: 'a'}
    end

    it 'should collect false and nil' do
      collect(E, {f: 'F', n: 'N'}).should == {f: false, n: nil}
    end

    it 'should filter' do
      collect(E, {a: 'A'}, {b: 'B'}, [/D/], 'XXX').should == {
        a: 'a',
        b: {'C' => 'c', 'D' => 'XXX'}
      }
    end
  end
end
