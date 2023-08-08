module Api::V1
  class PromosController < ApiBaseController
    skip_before_action :verify_authenticity_token
    before_action :find_promo, only: %i[show update destroy]

    def index
      @promos = Promo.all
      promos = { promos: serialized_promos }
      @promos.present? ? response_200('Fetched all the Promo Successfully', promos) : response_400('Promo is not Available')
    end

    def create
      @promo = Promo.new(promo_params)

      if @promo.save
        promo = serialized_promo
        response_200('Promo was successfully created', { promo: })
      else
        response_422(@promo.errors.full_messages.join(', '), 'Failed to save the Promo.')
      end
    end

    def show
      if @promo.present?
        promo = { promo: serialized_promo }
        response_200('Success', promo)
      else
        response_400('Promo could not be Found')
      end
    end

    def update
      if @promo.present?
        if @promo.update(promo_params)
          promo = { promo: serialized_promo }
          response_200('Promo was successfully updated.', promo)
        else
          response_422(@promo.errors.full_messages.join(', '), 'Failed to update the Company.')
        end
      else
        response_400('You cannot Update this Promo')
      end
    end

    def destroy
      if @promo.present?
        @promo.destroy
        promo = { promo: serialized_promo }
        response_200('Promo was Deleted Successfully', promo)
      else
        response_400('Promo does not Exist')
      end
    end

    private

    def promo_params
      params.require(:promo).permit(:name, :start_date, :end_date, :description, :status, :company_id, :promo_id,
                                    filter_option_ids: [])
    end

    def find_promo
      @promo = Promo.find_by(id: params[:id])
    end

    def serialized_promos
      PromoSerializer.new(Promo.all).serializable_hash[:data]
    end

    def serialized_promo
      PromoSerializer.new(@promo).serializable_hash[:data]
    end
  end
end
