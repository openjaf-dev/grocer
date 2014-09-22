require 'ffaker'

namespace :sample do
  desc 'Loads Sample Data'
  task :load => :environment do
    
    Account.delete_all
    puts 'All Account Deleted.'
    
    User.delete_all
    puts 'All User Deleted.'
    
    Organization.delete_all
    puts 'All Organization Deleted.'
    
    Image.delete_all
    puts 'All Image Deleted.'   
    
    Payment.delete_all
    puts 'All Payment Deleted.'
    
    Source.delete_all
    puts 'All Source Deleted.'
    
    OrderTotal.delete_all
    puts 'All Order_toral Deleted.'
    
    Property.delete_all
    puts 'All Property Deleted.'
    
    Variant.delete_all
    puts 'All Variant Deleted.'
    
    Option.delete_all
    puts 'All Variant Deleted.'
    
    Product.delete_all
    puts 'All Products Deleted.'
    
    Order.delete_all
    puts 'All Orders Deleted.'
    
    Address.delete_all
    puts 'All Address Deleted.'
    
    LineItem.delete_all
    puts 'All Line Item Deleted.'
    
    Taxonomy.delete_all
    puts 'All Taxonomy Deleted.'
    
    Taxon.delete_all
    puts 'All Taxon Deleted.'
    
    Adjustment.delete_all
    puts 'All Adjustment Deleted.'
        
    
    accounts = [
      {
      	organization_attributes: {
      		name: 'Grocer A',
      		phone: '',
      		anual_sales: "$0-$0.2M",
      		employees: '6-10',
      		organization_type: "Delicatessen",
      		demographic_market: "Indian",
      		address_attributes: {
            address1: Faker::AddressUS.street_address,
            zipcode: Faker::AddressUS.zip_code,
            city: Faker::AddressUS.city,
            state: Faker::AddressUS.state,
            country: "US",
            phone: "0000000000",
          },
      	},
      	users_attributes: [
        	{
        		name: Faker::Name.first_name,
        		email: 'user_a1@mail.com',
        		password: '12345678', 
        		password_confirmation: '12345678',
        	},
        	{
        		name: Faker::Name.first_name,
        		email: 'user_a2@mail.com',
        		password: '12345678', 
        		password_confirmation: '12345678',
        	}
        ],
      },
      {
      	organization_attributes: {
      		name: 'Grocer B',
      		phone: '7886699',
      		anual_sales: "$5.0M - $9.9M",
      		employees: '11-19',
      		organization_type: "Supermarket",
      		demographic_market: "Chinese",
      		address_attributes: {
            address1: Faker::AddressUS.street_address,
            zipcode: Faker::AddressUS.zip_code,
            city: Faker::AddressUS.city,
            state: Faker::AddressUS.state,
            country: "US",
            phone: "0000000000"
          },
      	},
      	users_attributes: [
        	{
        		name: Faker::Name.first_name,
        		email: 'user_b1@mail.com',
        		password: '12345678', 
        		password_confirmation: '12345678',
        	},
        	{
        		name: Faker::Name.first_name,
        		email: 'user_b2@mail.com',
        		password: '12345678', 
        		password_confirmation: '12345678',
          }
        ]
      }
    ]
    
    Account.create!(accounts)
    
    
    Account.all.each do |account|
    
      taxonomies = [
      	{ 
          account_id: account.id,
          name: "Categories" 
        },
      	{ 
          account_id: account.id,
          name: "Brand" 
        }
      ]

      taxonomies.each do |taxonomy_attrs|
        taxonomy = Taxonomy.new(taxonomy_attrs)
        taxonomy.save(validate: false)
      end

      categories = Taxonomy.unscoped.find_by_name!("Categories")
      brands = Taxonomy.unscoped.find_by_name!("Brand")
    
      taxons = [
        {
          name: "Categories",
          taxonomy: categories,
          account_id: account.id
        },
        {
          name: "Beverages",
          taxonomy: categories,
          parent: "Categories",
          account_id: account.id
        },
        {
          name: "Bread/Bakery",
          taxonomy: categories,
          parent: "Categories",
          account_id: account.id,
        },
        {
          name: "Canned/Jarred Goods",
          taxonomy: categories,
          parent: "Categories",
          account_id: account.id, 
        },
        {
          name: "Dairy",
          taxonomy: categories,
          parent: "Categories",
          account_id: account.id,
        },
        {
          name: "Cheeses",
          taxonomy: categories,
          parent: "Dairy",
          account_id: account.id,
        },
        {
          name: "Milk",
          taxonomy: categories,
          parent: "Dairy",
          account_id: account.id,
        },
        {
          name: "Eggs",
          taxonomy: categories,
          parent: "Dairy",
          account_id: account.id,
        },
        {
          name: "Yogourt",
          taxonomy: categories,
          parent: "Dairy",
          account_id: account.id,
        },
      
        {
          name: "Brands",
          taxonomy: brands,
          account_id: account.id,
        },
        {
          name: "Frozen Foods",
          taxonomy: brands,
          parent: "Brands",
          account_id: account.id,
        },
        {
          name: "Meat",
          taxonomy: brands,
          parent: "Brands",
          account_id: account.id,
        },
        {
          name: "Produce",
          taxonomy: brands,
          parent: "Brands",
          account_id: account.id,
        },
        {
          name: "Cleaners",
          taxonomy: brands,
          parent: "Brands",
          account_id: account.id,
        },
        {
          name: "Paper Goods",
          taxonomy: brands,
          parent: "Brands",
          account_id: account.id,
        },
      ]
    


      taxons.each do |taxon_attrs|
        if taxon_attrs[:parent]
          taxon_attrs[:parent] = Taxon.find_by(name: taxon_attrs[:parent])
          taxon = Taxon.new(taxon_attrs)
          taxon.save(validate: false)
        end
      end
    
      sizes = ["Small","Medium","Large","Extra Large"]
      colors = ["white", "Red","Green","Blue", "Black", "Yelow", "Lilac"]
      all_options = sizes.product colors
      states = ['complete','processing','incomplete']
    
   all_properties =  [
            {"Manufacturer" => ["Wilson","Jerseys"]},
            {"Brand" => ["Wannabe Sports","Resiliance","Conditioned","Wannabe Sports","JK1002"]},
            {"Model" => ["JK1002","TL174","TL9002"]},
            {"Shirt Type" => ["Baseball Jersey","Jr. Spaghetti T","Ringer T", "Baseball Jersey","Jr. Spaghetti T"]},
            {"Sleeve Type" => ["Long","None","Short","Long"]},
            {"Made from" => ["100% cotton","90% Cotton, 10% Nylon","100% Vellum","90% Cotton, 10% Nylon"]},
            {"Fit" => ["Loose","Form","Loose"]},
            {"Gender" => ["Men's","Women's"]},
            {"Type" => ["Tote","Messenger","Mug","Stein","Tote","Messenger"]},
            {"Size" => [ %Q{15" x 18" x 6"},%Q{14 1/2" x 12" x 5"}, %Q{4.5" tall, 3.25" dia.},
      	            %Q{6.75" tall, 3.75" dia. base, 3" dia. rim}, %Q{6.75" tall, 3.75" dia. base, 3" dia. rim},
      				%Q{4.5" tall, 3.25" dia.}, %Q{14 1/2" x 12" x 5"} ]},
            {"Material" => ["Canvas","600 Denier Polyester"]}
          ]
          
      1.upto 50 do 
        name = "#{Faker::Product.product }"
        sku = name.underscore.gsub(' ', '-')
        cost_price = rand(10.5...100.5).round(2)
        taxons = Taxon.all.shuffle.slice(0..rand(4))
        sub_set_prop = all_properties.shuffle.slice(0..rand(4))
        properties = sub_set_prop.map { |p| { account_id: account.id, "name" => p.keys[0], "presentation" => p.values[0].shuffle[0] } }
        options = all_options.shuffle.slice(0..(1 + rand(all_options.length)))
        height = 100 + rand(900)
        width = 100 + rand(900)
    
        variants = []
    
        options.each do |opt|
          height = 100 + rand(900)
          width = 100 + rand(900)
          size = opt[0]
          color = opt[1]
          variant = {
              account_id: account.id,
              "sku" => "#{sku}_#{size}_#{color}",
              "price" => cost_price + rand(30),
              "cost_price" => cost_price,
              "quantity" => rand(20),
              "options_attributes" => [
                {
                  account_id: account.id,
                  "option_type" => "color",
                  "option_value" => color},
                { 
                  account_id: account.id,
                  "option_type" => "size",
                  "option_value" => size
                },
              ],
          
          #    "images_attributes" => [
          #      {
          #        "url" => "http://lorempixel.com/#{height}/#{width}/",
          #        "position" => 1,
          #        "title" => "Spree T-Shirt - Grey Small",
          #        "type" => "thumbnail",
          #        "dimension_attributes" => { "height" => height,"width" => height }
          #      }
          #    ]
            }
            variants << variant
        end  
    
        product = {
            account_id: account.id,
            "name" => name,
            "sku" => sku,
            #"description" => Faker::Lorem.paragraphs(paragraph_count = 3),
            "price" => cost_price + rand(30),
            "cost_price" => cost_price,
            "available_on" => DateTime.now,
            "permalink" =>  sku,
            "meta_description" => nil,
            "meta_keywords" => nil,
            "shipping_category" => "Default",
           # "taxons_attributes" => taxons,
        #    "options" => [ "color","size"],
            "properties_attributes" => properties,
        #    "images_attributes" => [
        #      {
        #        "url" => "http://lorempixel.com/#{height}/#{width}/",
        #        "position" => 1,
        #        "title" => sku,
        #        "type" => "thumbnail",
        #        "dimension_attributes" => { "height" => height,"width" => height }
        #      }
        #    ],
            "variants_attributes" => variants
          }
    
        p1 =  Product.new(product)
        p1.taxons = taxons
        p1.save(validate: false)
 
        # orders 
        num_orders = 1 + rand(20)
        1.upto num_orders do
          total = rand(10.5...400.5).round(2)

          tax = rand 20
          shipping = rand 20
          adjustment = rand 20
          quantity = 1 + rand(5)
          item_price = total - ( tax + shipping)

          order = {
              account_id: account.id,
              "number" => Faker::Product.letters(7),
              "status" => states[rand(3)],
              "channel" => "spree",
              "email" => "spree@example.com",
              "currency" => "USD",
              "placed_on" => DateTime.now - rand(20).months - rand(31).days-rand(24).hours-rand(60).minutes-rand(60).seconds,
              "totals_attributes" => {
                account_id: account.id,
                "item" => item_price,
                "adjustment" => adjustment,
                "tax" => tax,
                "shipping" => shipping,
                "payment" => item_price,
                "total" => item_price
              },
              "line_items_attributes" => [
                {
                  account_id: account.id,
                  "product_id" => sku,
                  "name" => "Spree T-Shirt",
                  "quantity" => quantity,
                  "price" => item_price/quantity
                }
              ],
              "adjustments_attributes" => [
                {
                  account_id: account.id,
                  "name" => "Tax",
                  "value" => 10.0
                },
                {
                  account_id: account.id,
                  "name" => "Shipping",
                  "value" => 5.0
                },
                {
                  account_id: account.id,
                  "name" => "Shipping",
                  "value" => 5.0
                }
              ],
              "ship_address_attributes" => {
                account_id: account.id,
                "firstname" => Faker::Name.first_name,
                "lastname" => Faker::Name.last_name,
                "address1" => Faker::AddressUS.street_address,
                "address2" => Faker::AddressUS.secondary_address,
                "zipcode" => Faker::AddressUS.zip_code,
                "city" => Faker::AddressUS.city,
                "state" => Faker::AddressUS.state,
                "country" => "US",
                "phone" => "0000000000"
              },
              "bill_address_attributes" => {
                account_id: account.id,
                "firstname" => Faker::Name.first_name,
                "lastname" => Faker::Name.last_name,
                "address1" => Faker::AddressUS.street_address,
                "address2" => Faker::AddressUS.secondary_address,
                "zipcode" => Faker::AddressUS.zip_code,
                "city" => Faker::AddressUS.city,
                "state" => Faker::AddressUS.state,
                "country" => "US",
                "phone" => "0000000000"
              },
              "payments_attributes" => [
                {
                  account_id: account.id,
                  "number" => rand(1000),
                  "status" => "completed",
                  "amount" => item_price,
                  "payment_method" => "Credit Card",
                  "source_attributes" => {
                      account_id: account.id,
                      "name" => "#{Faker::Name.first_name} #{Faker::Name.last_name}",
                      "cc_type" => ['visa', 'american_express', 'master', 'discover'].shuffle.first,
                      "month" => 1 + rand(12),
                      "year" => rand(2015..2030),
                      "last_digits" => rand(10000),
                    }
                }
              ]
            }
      
          o = Order.new(order)
          o.save(validate: false)
        end
      
      end
      
    end # account
     
  end
end


