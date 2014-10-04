RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
   config.authenticate_with do
     warden.authenticate! scope: :user
   end
   config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  
#  config.excluded_models = [
#    Classification,
#    Account,
#    AdminUser
#  ]
  
  config.included_models = [
    Product,
    Order,
    LineItem,
    Shipment,
    User,
    Organization 
  ]
  
  config.model 'User' do
   field :name
   field :email
   field :password
   field :password_confirmation
   
  end
  
  config.model 'Organization' do 

    visible false

    field :name    
    
    field :employees, :enum do
      
      enum do
        ['1-5','6-10', '11-19', '20+']
      end
      
      default_value "$0-$0.2M"
       
    end  
    
    field :organization_type, :enum do 
      
      enum do
        
    		["Convenience","Delicatessen","Greengrocer (Fruits and Vegetables)",	
    		"Health food store",	"Coffee Shop",	"Supermarket",	"Hypermarket"]
      end

      default_value "Convenience"
      
    end
    
    
    field :anual_sales, :enum do 

      enum do
        ["$0-$0.2M", "$0.2M - $0.5M", "$0.5M - $1.0M","$1.0M - $5.0M", "$5.0M - $9.9M", "$10.0M+"]
      end
      
      default_value "$0-$0.2M"
      
    end
    
    field :demographic_market, :enum do 
      
      enum do
        ["General","Hispanic","Chinese","Indian","Other Asian",	"European","African"]
      end
      
      default_value "General"
      
    end

  end
  

  config.actions do
    dashboard                     # mandatory
    
    index
    new
    export
    bulk_delete
    
#    index do
#      except ['Organization']
#    end  
    
#    new do
#      except ['Organization']
#    end
    
#    export do
#      except ['Organization']
#    end
    
#    bulk_delete do
#      except ['Organization']
#    end
    
    show
    
    edit
    
    delete
    
    #show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
