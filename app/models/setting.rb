class Setting < ActiveRecord::Base
  attr_accessible :key, :val, :setting_type

  validates_presence_of :key, :value, :setting_type

  def val=(value)
    self.value = JSON.generate("value" => value)
  end

  def val
    JSON.parse(self.value)["value"]
  end

  def self.setting_for(key)
    self.find_by_key(key)
  end
end
