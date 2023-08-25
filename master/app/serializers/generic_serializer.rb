# app/serializers/generic_serializer.rb
class GenericSerializer < ActiveModel::Serializer
  def attributes(*args)
    object.attributes.symbolize_keys
  end
end
