class WebhookController < ApplicationController
  def created_order
    return unless params[:status].eql?('completed')

    products_to_bill = params

    # @api_cimo.post('bills', products_to_bill)
  end


  def health_test
    @products = Product.all
    render json: {status: 'healthy'}, status: :ok
  end

end
