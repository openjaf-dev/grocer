class OrganizationStepsController < ApplicationController
  include Wicked::Wizard
  steps :organization, :organization_address
  
  before_action :print_params
  
  def show
    @organization = Organization.find(params[:organization_id])
    render_wizard
  end
  
  def update
    @organization = Organization.find(params[:organization_id])
    @organization.attributes = permit_params
    @organization.save!
    
    redirect_to wizard_path(next_step, organization_id: @organization.id)
  end

  def create
    current_user.save
    puts "************ en create current_user. #{current_user.inspect}"
    @organization = current_user.account.organization #current_user.account.organization
    raise Exception.new("Can't find organization") unless @organization 
    redirect_to wizard_path(steps.first, organization_id: @organization.id)
  end
  
private

  def redirect_to_finish_wizard(options = {})

    redirect_to root_url, notice: "Thank you for signing up."
  end
  
  def permit_params    
    params.require(:organization).permit(:name, :employees, :organization_type, :demographic_market,
    address_attributes: [:address1,:address2,:city,:state,:country,:phone, :zipcode] )
  end  
  
  def print_params
    puts "************************ params #{params.inspect} "
  end  
    

end
