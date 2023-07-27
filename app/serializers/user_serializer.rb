class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :first_name, :last_name, :age, :dob
end
