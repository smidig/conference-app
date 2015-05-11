require 'spec_helper'

describe Setting do
  describe '.new' do
    it 'should require a key' do
      setting = Setting.new(:key => nil)
      setting.invalid?.should be_true
      setting.errors[:key].should be_true
    end

    it 'should require a value' do
      setting = Setting.new(:val => nil)
      setting.invalid?.should be_true
      setting.errors[:value].should be_true
    end

    it 'should require a type' do
      setting = Setting.new(:setting_type => nil)
      setting.invalid?.should be_true
      setting.errors[:setting_type].should be_true
    end

    it 'should create new instance' do
      setting = Setting.new(:key=>'key', :val=> 'value', :setting_type=> 'string')
      setting.save!
      setting.valid?.should be_true
      Setting.find(setting.id).should eq(setting)
    end
  end
end
