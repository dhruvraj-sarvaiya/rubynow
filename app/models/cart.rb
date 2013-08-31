class Cart < ActiveRecord::Base
  has_many :line_items
  
  def total_price
    # convert to array so it doesn't try to do sum on database directly
    line_items.to_a.sum(&:full_price)
  end
  
  def paypal_url(return_url)
    values = {
      :business => 'seller_1229899173_biz@railscasts.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id
    }
    line_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.unit_price,
        "item_name_#{index+1}" => item.product.name,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end

# require 'rubygems'
# require 'active_merchant'

# # Use the TrustCommerce test servers
# ActiveMerchant::Billing::Base.mode = :test

# gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
# gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
#             :login => 'TestMerchant',
#             :password => 'password')

# # ActiveMerchant accepts all amounts as Integer values in cents
# amount = 1000  # $10.00

# # The card verification value is also known as CVV2, CVC2, or CID
# credit_card = ActiveMerchant::Billing::CreditCard.new(
#                 :first_name         => 'Bob',
#                 :last_name          => 'Bobsen',
#                 :number             => '4242424242424242',
#                 :month              => '8',
#                 :year               => Time.now.year+1,
#                 :verification_value => '000')

# # Validating the card automatically detects the card type
# if credit_card.valid?
#   # Capture $10 from the credit card
#   response = gateway.purchase(amount, credit_card)

#   if response.success?
#     puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
#   else
#     raise StandardError, response.message
#   end
# end


# require 'rubygems'
# require 'authorize_net'

# transaction = AuthorizeNet::AIM::Transaction.new('YOUR_API_LOGIN_ID', 'YOUR_TRANSACTION_KEY',
#   :gateway => :sandbox)
# credit_card = AuthorizeNet::CreditCard.new('4111111111111111', '1120')
# response = transaction.purchase('10.00', credit_card)

# if response.success?
#   puts "Successfully made a purchase (authorization code: #{response.authorization_code})"
# else
#   raise "Failed to make purchase."
# end