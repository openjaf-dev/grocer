class OrganizationStepsController < ApplicationController
  include Wicked::Wizard
  steps :organization , :organization_address
  
  def show
    current_user.account.organization ||= Organization.new 
    @organization ||= current_user.account.organization
    render_wizard
  end
  
  def update
    current_account = current_user.account
    current_account.organization ||= Organization.new 
    @organization ||= current_user.account.organization
    @organization.attributes = permit_params
    @organization.save!
    
    puts "&&&&&&&&&&&&&&&&&&&& @organization &&&&&& #{@organization.inspect}"
    
    current_account.update_attributes(organization: @organization)
    
    puts "&&&&&&&&&&&&&&&&&&&&&&&&&& current_account #{current_account.organization.inspect}"
    
    render_wizard @organization
  end

  def create
    @organization = Organization.create
    redirect_to wizard_path(steps.first, :organization_id => @organization.id)
  end
  
  
  
private

  def redirect_to_finish_wizard(options = {})
    redirect_to root_url, notice: "Thank you for signing up."
  end
  
  def permit_params    
    params.require(:organization).permit(:name, :employees, :organization_type, :demographic_market,
    address_attributes: [:address1,:address2,:city,:state,:country,:phone, :zipcode] )
  end  

end
