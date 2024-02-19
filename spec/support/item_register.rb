module ItemRegister
  def item_register(item)
    visit new_item_path
    fill_in '商品名', with: item.title
    fill_in '数', with: item.count
    fill_in '賞味期限', with: item.expired_at
    fill_in 'item[detail]', with: item.detail
    click_on '登録'
  end

  def register_multiple_items(count)
    count.times do
      item = FactoryBot.build(:item)
      item_register(item)
    end
  end
end
