# encoding: utf-8

require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Backup::Storage::EngineYard' do
  let(:model)   { Backup::Model.new(:test_trigger, 'test label') }
  let(:storage) do
    Backup::Storage::EngineYard.new(model) do |ey|
      ey.instance_token     = 'my_instance_token'
    end
  end

  it 'should be a subclass of Storage::Base' do
    Backup::Storage::EngineYard.
      superclass.should == Backup::Storage::Base
  end

  describe '#initialize' do
    after { Backup::Storage::EngineYard.clear_defaults! }

    it 'should load pre-configured defaults through Base' do
      Backup::Storage::EngineYard.any_instance.expects(:load_defaults!)
      storage
    end

    it 'should pass the model reference to Base' do
      storage.instance_variable_get(:@model).should == model
    end

    it 'should pass the storage_id to Base' do
      storage = Backup::Storage::EngineYard.new(model, 'my_storage_id')
      storage.storage_id.should == 'my_storage_id'
    end

    context 'when no pre-configured defaults have been set' do
      it 'should use the values given' do
        storage.instance_token.should      == 'my_instance_token'
        storage.storage_id.should be_nil
      end

      it 'should use default values if none are given' do
        storage = Backup::Storage::EngineYard.new(model)

        storage.instance_token.should      be_nil
        storage.storage_id.should be_nil
      end
    end # context 'when no pre-configured defaults have been set'

    context 'when pre-configured defaults have been set' do
      before do
        Backup::Storage::EngineYard.defaults do |s|
          s.instance_token      = 'my_instance_token'
        end
      end

      it 'should use pre-configured defaults' do
        storage = Backup::Storage::EngineYard.new(model)

        storage.instance_token.should      == 'my_instance_token'
        storage.storage_id.should be_nil
      end

      it 'should override pre-configured defaults' do
        storage = Backup::Storage::EngineYard.new(model) do |s|
          s.instance_token      = 'new_instance_token'
        end

        storage.instance_token.should      == 'new_instance_token'
        storage.storage_id.should be_nil
      end
    end # context 'when pre-configured defaults have been set'
  end # describe '#initialize'


  describe '#connection' do
    let(:connection) { mock }

    it 'should create a new connection'

    it 'should return an existing connection'
  end # describe '#connection'


  describe '#transfer!' do
    let(:connection) { mock }
    let(:package) { mock }
    let(:file) { mock }
    let(:s) { sequence '' }

    before do
      storage.instance_variable_set(:@package, package)
      storage.stubs(:storage_name).returns('Storage::EngineYard')
      storage.stubs(:local_path).returns('/local/path')
      storage.stubs(:connection).returns(connection)
    end

    it 'should transfer the package files'
  end # describe '#transfer!'

  describe '#remove!' do
    let(:package) { mock }
    let(:connection) { mock }
    let(:s) { sequence '' }

    before do
      storage.stubs(:storage_name).returns('Storage::EngineYard')
      storage.stubs(:connection).returns(connection)
    end

    it 'should remove the package files' 
  end # describe '#remove!'
end

