require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
      ##Returns all the full error messages in an array.

      it "Should not create product if name is not included" do
        @category = Category.create(name: 'Testing')
        @product = @category.products.create({
          name:  nil, #Test 1
          quantity: 99,
          price_cents: 987.65
        })
        expect(@product.valid?).to eq(false)
      end

       it "Should not create product if price is not included" do
        @category = Category.create(name: 'Testing')
        @product = Product.new(
          name:  '3D Larry Printer', 
          quantity: 99,
          price_cents: nil) 
        # @product = @category.products.create({
        #   name:  '3D Larry Printer', 
        #   quantity: 99,
        #   price_cents: nil #Test 2
        # }) 
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts @product.errors.full_messages.to_s
        kirkland = @product.errors.full_messages.include?("Price can't be blank")
        expect(kirkland).to eq(true)
      end

      it "Should not create product if quantity is not included" do
        @products = Product.new(name: 'prod 1', description: "bla bla", image: "image url", price_cents: 1200, quantity: 4 )
        expect(@products).to_not be_nil
      end

      it 'should not save without valid category id' do
        @category = Category.create(name: "Special")
        category_id = Product.new(
          name: nil,
          price: 34.00,
          quantity: 15,
          category_id: nil
          )
        expect(category_id).to_not (be_valid)
      end


    end 
end