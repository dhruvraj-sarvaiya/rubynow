class PaymentsController < ApplicationController	

	def new
	    @payment = Payment.new
	    @creditcard = ActiveMerchant::Billing::CreditCard.new
	 end
 
	def create
		# raise params[:payment][:amount].inspect
	    @payment = Payment.new(params[:payment])
	    @creditcard = ActiveMerchant::Billing::CreditCard.new(params[:creditcard])
	    @billing_address = { :name => 'Mark McBride', :address1 => '1 Show Me The Money Lane',
:city => 'San Francisco', :state => 'CA',
:country => 'US', :zip => '23456', :phone => '(555)555-5555' }
		@options = {:address => {}, :billing_address => @billing_address}
	    # if(@creditcard.valid?)
	    # 	raise 'true'
	    # else
	    # 	#raise @payment.inspect
	    # 	raise 'false'
	    # end
	    # @payment.valid_card = @creditcard.valid?
	    # if @payment.valid?
	    #   	@payment = @payment.process_payment(@creditcard)
	    #   	if @payment.success?
	    #     	@payment.save
	    #     	flash[:notice] = I18n.t('payment.success')
	    #     	redirect_to payments_url and return
	    #   	else
	    #     	flash[:error] = I18n.t('payment.failed')
	    #   	end
	    # end
	    # render :action => :new

	     @charge_amount = (params[:payment][:amount])
	     @charge_amount = (@charge_amount.to_f * 100)

	    if @creditcard.valid?
			gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
			 :login  => '95SGtLme3b',
			 :password => '65PZ8mEWdT6K47dq'
			)
			@response = gateway.purchase(@charge_amount, @creditcard,@options)
			
			# if @response.success?
			if @response.params['response_code'].to_s == "1"
			 # puts "success!"
			 flash[:success] = "success!"
			else
			 # raise StandardError.new( response.message )
			 flash[:success] = "#{@response.params['response_code']}: #{@response.message}"
			end
		end
		render :action => :new
	end

	def sellect_payment
		 @jobpost = Jobpost.find(params[:id])
    	 @jobpost_detail = Jobpostdetail.find_by_jobpost_id(@jobpost.id)
    	 @payment = Payment.new

	end

	def credit_card
		#raise params.inspect
		 @payment = Payment.new
		 @payment.amount = 1
	     @creditcard = ActiveMerchant::Billing::CreditCard.new
	     @payment_billing_info = PaymentBillingInfo.new

	end

	def credit_card_confirm
		# raise params[:creditcard].inspect
		# raise params.inspect
		@payment = Payment.new(params[:payment])
		@payment_billing_info = PaymentBillingInfo.new(params[:payment_billing_info])
		#raise @payment.inspect
		params[:creditcard][:first_name] = params[:payment_billing_info][:first_name]
		params[:creditcard][:last_name] = params[:payment_billing_info][:last_name]
	    @creditcard = ActiveMerchant::Billing::CreditCard.new(params[:creditcard])
	    # raise @creditcard.inspect
	 #    @billing_address = { :name => 'Mark McBride', :address1 => '1 Show Me The Money Lane',
		# :city => 'San Francisco', :state => 'CA',
		# :country => 'US', :zip => '23456', :phone => '(555)555-5555' }
		# @options = {:address => {}, :billing_address => @billing_address}

		@billing_address = { 
			:name => "#{params[:payment_billing_info][:first_name]} #{params[:payment_billing_info][:last_name]}", 
			:address1 => "#{params[:payment_billing_info][:add_1]} #{params[:payment_billing_info][:add_2]}",
			:city => "#{params[:payment_billing_info][:city]}", 
			:state => "#{params[:payment_billing_info][:state]}",
			:country => "#{params[:payment_billing_info][:country_id]}", 
			:zip => "#{params[:payment_billing_info][:zip]}", 
			:phone => "#{params[:payment_billing_info][:phone]}"}
			# raise @billing_address.inspect

		@options = {:address => {}, :billing_address => @billing_address}


		 @charge_amount = (params[:payment][:amount])
	     @charge_amount = (@charge_amount.to_f * 100)

	     # raise @creditcard.valid?.inspect

	    if @creditcard.valid?
			gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
			 :login  => '95SGtLme3b',
			 :password => '23aHc6d4Y4329pSu'
			)
			@response = gateway.purchase(@charge_amount, @creditcard,@options)
			
			# if @response.success?
			if @response.params['response_code'].to_s == "1"
				 # puts "success!"
				 @payment.status = 1
				 @payment.transaction_number = @response.params['response_code']
				 if @payment.save			 	
				 	@payment_billing_info.payment_id = @payment.id
				 	@payment_billing_info.save
				 end		
				 raise "#{params.inspect}: #{@payment}: #{@payment_billing_info}"	
			 	flash[:success] = "success!"
			else
				 # raise StandardError.new( response.message )
				 flash[:success] = "#{@response.params['response_code']}: #{@response.message}"
				 raise @response.inspect
				 #render :action => :credit_card
			end
				respond_to do |format|
		      		format.html # index.html.erb
		      		format.json { render json: @jobposts }
		    	end
		else
			raise @creditcard.inspect
			render :action => :credit_card
		end		
      
	end
end

# @params={"response_code"=>3, 
# 	"response_reason_code"=>"11", 
# 	"response_reason_text"=>"A duplicate transaction has been submitted.", 
# 	"avs_result_code"=>"P", 
# 	"transaction_id"=>"0", 
# 	"card_code"=>"", 
# 	"action"=>"AUTH_CAPTURE"},
# @message="A duplicate transaction has been submitted", 
# @success=false, 
# @test=true, 
# @authorization="0", 
# @fraud_review=false, 
# @avs_result={"code"=>"P", "message"=>"Postal code matches, but street address not verified.", "street_match"=>nil, "postal_match"=>"Y"}, 
# @cvv_result={"code"=>nil, "message"=>nil}