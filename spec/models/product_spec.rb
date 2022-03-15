require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    before(:each) do
      @category = Category.create(
        name: 'Horses'
      )
      @product = Product.new(
        name: 'Chestnut',
        price_cents: 123.12,
        quantity: 23,
        category_id: @category.id
      )
    end

    it 'saves successfully when all fields are completed' do
      @product.save
      saved_product = Product.find(@product.id)
      expect(saved_product).to eq(@product)
    end

    context 'given a blank required field' do
      it 'returns an error when the name is blank' do
        @product.name = nil
        @product.save
        test_errors = @product.errors.full_messages
  
        expect(test_errors).to include "Name can't be blank"
      end
  
      it 'returns an error when the price is blank' do
        @product.price_cents = nil
        @product.save
        test_errors = @product.errors.full_messages
  
        expect(test_errors).to include "Price is not a number"
      end
  
      it 'returns an error when the quantity is blank' do
        @product.quantity = nil
        @product.save
        test_errors = @product.errors.full_messages
  
        expect(test_errors).to include "Quantity can't be blank"
      end
  
      it 'returns an error when the category is blank' do
        @product.category_id = nil
        @product.save
        test_errors = @product.errors.full_messages
  
        expect(test_errors).to include "Category can't be blank"
      end
    end

  end
end
