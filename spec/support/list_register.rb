module ListRegister
  def list_register(shopping_list)
    visit new_shopping_list_path
    fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][product]', with: shopping_list.product
    fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][number]', with: shopping_list.number
    fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][trait]', with: shopping_list.trait
    click_button '買い物リストに登録'
  end
end
  