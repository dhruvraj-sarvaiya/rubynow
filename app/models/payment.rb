class Payment < ActiveRecord::Base
  attr_accessible :amount, :status, :transaction_number
  has_one :usermembership
  has_one :paymentbillinginfo

  PROCESSING, FAILED, SUCCESS = 1, 2, 3
 
  #validates :valid_card, :inclusion => {:in => [true,false], :message => 'Invalid Credit Card'}
  validates :amount, :presence => true, :numericality => { :greater_than => 0 }
  #validates :visa, :mc, :discover, :amex, :presence => true, :if => :credit_card?
 
  def process_payment(creditcard)
    ActiveMerchant::Billing::Base.mode = auth['mode'].to_sym
    self.status = PROCESSING
    response = gateway.purchase(amount * 100, creditcard)
 
    if response.success?
      self.transaction_number = response.subscription_id
      self.status = SUCCESS
    else
      self.status = FAILED
    end
    return self
  rescue Exception => e
    self.status = FAILED
    return self
  end
 
  def success?
    self.status == SUCCESS
  end

  def credit_card?
    credit_card.present?
  end

  # def valid_card(valid)
  #  valid_card =  valid.to_s
  # end
 
  private
  def gateway
    ActiveMerchant::Billing::AuthorizeNetGateway.new(
      :login    => auth['login'],
      :password => auth['key'])
  end
 
  def auth
    @@auth ||= YAML.load_file("#{Rails.root}/config/authorize_net.yml")[Rails.env]
  end
end
