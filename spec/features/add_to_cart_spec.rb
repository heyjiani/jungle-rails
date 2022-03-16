require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

      # SETUP
      before :each do
        @category = Category.create! name: 'Apparel'
    
        10.times do |n|
          @category.products.create!(
            name:  Faker::Hipster.sentence(3),
            description: Faker::Hipster.paragraph(4),
            image: open_asset('apparel1.jpg'),
            quantity: 10,
            price: 64.99
          )
        end
      end
    
      scenario "They can add a product to cart by clicking on the 'Add' button" do
        # ACT
        visit root_path
        expect(page).to have_content 'My Cart (0)'
        click_button('Add', match: :first)
    
        # DEBUG / VERIFY
        save_screenshot
    
        expect(page).to have_content 'My Cart (1)'
    
      end
      
end
