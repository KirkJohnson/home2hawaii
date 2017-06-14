class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :edit, :destroy, :update , :index]

  # GET /leads
  # GET /leads.json
  def index
    @leads = Lead.where("user_id", current_user.id)
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
  end

  # GET /leads/new
  def new
    @lead = Lead.new
    @user = (params[:acct]) ? User.find(params[:acct]) : User.first
    @location = ""
    @location = params[:location] ? params[:location].gsub(/_/, " ").gsub(/-/," ").split.map(&:capitalize).join(' ')
                                    : "Hawaii"
 
    @no_menu = true
    
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(lead_params)
    @lead.processed = false

    respond_to do |format|
      if @lead.save
        
        LeadNotifier.new_lead_notification.deliver
        format.html do
          redirect_to "http://www.home2hawaii.com"
        end
        format.json { render :show, status: :created, location: @lead }
        #format.html { redirect_to @lead, notice: 'Lead was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Lead was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
      params.require(:lead).permit(:location, :email, :comment, :user_id, :processed)
    end
end
