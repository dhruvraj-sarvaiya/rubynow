class JobpostsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  #helper_method:signed_in_user,:correct_user
  
  COUNTRY = ["Afghanistan", "Aland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola",
        "Anguilla", "Antarctica", "Antigua And Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria",
        "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin",
        "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil",
        "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia",
        "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China",
        "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo",
        "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba",
        "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt",
        "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)",
        "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia",
        "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea",
        "Guinea-Bissau", "Guyana", "Haiti", "Heard and McDonald Islands", "Holy See (Vatican City State)",
        "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran, Islamic Republic of", "Iraq",
        "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya",
        "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan",
        "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya",
        "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Macedonia, The Former Yugoslav Republic Of",
        "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique",
        "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of",
        "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru",
        "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger",
        "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau",
        "Palestinian Territory, Occupied", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines",
        "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation",
        "Rwanda", "Saint Barthelemy", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia",
        "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino",
        "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore",
        "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa",
        "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "Sudan", "Suriname",
        "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic",
        "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Timor-Leste",
        "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
        "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom",
        "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela",
        "Viet Nam", "Virgin Islands, British", "Virgin Islands, U.S.", "Wallis and Futuna", "Western Sahara",
        "Yemen", "Zambia", "Zimbabwe"]
  # GET /jobposts
  # GET /jobposts.json
  def index
    @jobposts = Jobpost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobposts }
    end
  end

  # GET /jobposts/1
  # GET /jobposts/1.json
  def show
    @jobpost = Jobpost.find(params[:id])
    @jobpost_detail = Jobpostdetail.find_by_jobpost_id(@jobpost.id)
    @country = COUNTRY

    require 'rubygems'
    require 'authorize_net'

    transaction = AuthorizeNet::AIM::Transaction.new('95SGtLme3b', '65PZ8mEWdT6K47dq',
      :gateway => :sandbox)
    credit_card = AuthorizeNet::CreditCard.new('4111111111111111', '1120')
    response = transaction.purchase('10.04', credit_card)
    #raise response.inspect
    if response.success?
      puts "Successfully made a purchase (authorization code: #{response.authorization_code})"
    else
      raise "Failed to make purchase."
    end

    #raise response.inspect
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jobpost }
    end
  end

  # GET /jobposts/new
  # GET /jobposts/new.json
  def new
    @jobpost = Jobpost.new
    @country = COUNTRY
      
      @user ||= User.find_by_remember_token(cookies[:remember_token])


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jobpost }
    end
  end

  # GET /jobposts/1/edit
  def edit
    # raise JobpostsController.action_methods.inspect
    signed_in_user
    @jobpost = Jobpost.find(params[:id])
   
    @country = COUNTRY

        @user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  # POST /jobposts
  # POST /jobposts.json
  def create
    @jobpost = Jobpost.new(params[:jobpost])

    respond_to do |format|
      if @jobpost.save
        format.html { redirect_to @jobpost, notice: 'Jobpost was successfully created.' }
        format.json { render json: @jobpost, status: :created, location: @jobpost }
      else
        format.html { render action: "new" }
        format.json { render json: @jobpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobposts/1
  # PUT /jobposts/1.json
  def update
    #raise params.inspect
    @jobpost = Jobpost.find(params[:id])
    @jobpost.user_id= current_user.object_id.inspect

    @country = COUNTRY
    respond_to do |format|
      if @jobpost.update_attributes(params[:jobpost])
        #format.html { redirect_to @jobpost, notice: 'Jobpost was successfully updated.' }
        #format.html { redirect_to jobpostdetail_path(:id => params[:id]), notice: 'Jobpost was successfully updated.' }
        #format.html { redirect_to jobpostdetail_jobpost_path(@jobpost), notice: 'Jobpost was successfully updated.' }
        format.html { redirect_to editjobpostdetail_path(@jobpost), notice: 'Jobpost was successfully updated.' }
        
        #render action: "jobdetail"
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jobpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobposts/1
  # DELETE /jobposts/1.json
  def destroy
    @jobpost = Jobpost.find(params[:id])
    @jobpost.destroy

    respond_to do |format|
      format.html { redirect_to jobposts_url }
      format.json { head :no_content }
    end
  end

  def edit_jobpostdetail
    #raise params.inspect
    @jobpost = Jobpost.find(params[:id])
    @jobpost_detail = Jobpostdetail.find_by_jobpost_id(@jobpost.id)
  end

  def update_jobpostdetail
    #raise params[:jobpost_detail].inspect
    #raise params.inspect
    @jobpost = Jobpost.find(params[:jobpost][:id])
    @jobpost_detail = Jobpostdetail.find_by_jobpost_id(@jobpost.id)

    respond_to do |format|
      if @jobpost_detail.update_attributes(params[:jobpostdetail])
        #raise jobpost_path.inspect
        flash[:success] = "Jobpost was successfully updated."
        #redirect_to root_path
        #raise
       
        format.html { redirect_to jobpost_path, notice: 'Jobpost was successfully updated.' }       
        format.json { head :no_content }
      else
        #raise @jobpost_detail.errors.inspect
        format.html { render editjobpostdetail_path(@jobpost)}
        format.json { render json: @jobpost_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def payment_option
    @jobpost = Jobpost.find(params[:id])
    @jobpost_detail = Jobpostdetail.find_by_jobpost_id(@jobpost.id)
  end

  private

    # def signed_in_user
    #   raise SessionsHelper.signed_in?
    #   @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    #   # # raise @current_user.inspect
    #   #raise current_user.nil?.inspect
    # end    

    def correct_user
      #@user = User.find(params[:id])
      #redirect_to(root_path) unless current_user?(@user)

      @jobpost = current_user.jobposts.find_by_id(params[:id])
      # raise @jobpost.inspect
      redirect_to root_path,notice:'You are authorize to access this page' if @jobpost.nil?
    end
end
