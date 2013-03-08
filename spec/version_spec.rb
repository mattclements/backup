# encoding: utf-8

require File.expand_path('../spec_helper.rb', __FILE__)

def set_version(major, minor, patch, engine_yard_version)
  Backup::Version.stubs(:major).returns(major)
  Backup::Version.stubs(:minor).returns(minor)
  Backup::Version.stubs(:patch).returns(patch)
  Backup::Version.stubs(:engine_yard_version).returns(engine_yard_version)
end

describe Backup::Version do
  it 'should return a nicer gemspec output' do
    set_version(1, 2, 3, 4)
    Backup::Version.current.should == '1.2.3.4'
  end

  it 'should return a nicer gemspec output with build' do
    set_version(5, 6, 7, 8)
    Backup::Version.current.should == '5.6.7.8'
  end
end
