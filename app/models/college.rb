class College
  include ActiveModel::Conversion
  include ActiveModel::API

  attr_accessor :id, :name, :lat, :lon
end