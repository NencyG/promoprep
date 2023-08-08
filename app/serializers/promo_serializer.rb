class PromoSerializer
  include JSONAPI::Serializer
  attributes :name, :start_date, :end_date, :description, :company_id
end
