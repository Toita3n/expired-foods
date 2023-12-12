class ShoppingListCollectionForm
  include ActiveModel::Model
  include ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  FORM_COUNT = 5
  attr_accessor :shopping_lists

  def initialize(attributes = {})
    super attributes
    self.shopping_lists = FORM_COUNT.times.map { ShoppingList.new() } unless self.shopping_lists.present?
  end

  def shopping_lists_attributes=(attributes)
    self.shopping_lists = attributes.map {|_, v| ShoppingList.new(v)}
  end

  def save
    ShoppingList.transaction do
        self.shopping_lists.map do |shopping_list|
            if shopping_list.availability
                shopping_list.save
            end
        end
    end
  end
end