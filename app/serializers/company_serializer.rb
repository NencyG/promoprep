class CompanySerializer
  include JSONAPI::Serializer

  attributes :name, :email, :user_id
end
