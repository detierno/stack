CheckoutController.class_eval do
  before_filter :redirect_to_stack_if_needed, :only => [:update]
  
  # def create_stac_order_checkout_url(order, payment_method)
  #   AprovaFacilStack::Config.user = 'apimentese'
  #   AprovaFacilStack::Config.test = true
  # 
  #   aprova_trans = AprovaFacilStack.new
  #   link = aprova_trans.generate_token(@order.number, @order.total, '01')
  # 
  #   uri = URI(link)
  #   response = Net::HTTP.get(uri)
  #   token = response.strip
  # 
  #   payment_url =  aprova_trans.token_action('APC', token)
  #   logger.info { "URL PAYMENT >>>> #{payment_url}" }
  #   redirect_to payment_url
  # end
  
  
private

  def redirect_to_stack_if_needed
    return unless (params[:state] == "payment")
    if params[:order][:coupon_code]
      @order.update_attributes(object_params)
      @order.process_coupon_code
    end
    load_order
    payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])

    if payment_method.kind_of?(PaymentMethod::SpreeAprovaStack)
      AprovaFacilStack::Config.user = 'apimentese'
      AprovaFacilStack::Config.test = true

      aprova_trans = AprovaFacilStack.new
      link = aprova_trans.generate_token(@order.number, @order.total, '01')

      uri = URI(link)
      response = Net::HTTP.get(uri)
      token = response.strip

      payment_url =  aprova_trans.token_url(token)
      logger.info { "URL PAYMENT >>>> #{payment_url}" }
      redirect_to payment_url
    end
  end
  
end