require 'rails_helper'

  describe '冷蔵庫の中身の一覧機能', type: :system do
    let(:user_a) { FactoryBot.create(:user, password: 'testpassword', password_confirmation: 'testpassword')}
    let(:user_b) { FactoryBot.create(:user, password: 'testpassword', password_confirmation: 'testpassword')}
    let!(:item_c) { FactoryBot.create(:item, title: 'うどん', count: '2', expired_at: DateTime.new(2035, 7, 5), detail: 'test_words', user: user_a )}
    before do
      FactoryBot.create(:item, title: '最初の商品', count: '2', expired_at: DateTime.new(2030, 5, 5), detail: 'test_words', user: user_a )
      FactoryBot.create(:item, title: '期限切れ', count: '32', expired_at: DateTime.new(2000, 5, 5), detail: 'Unfortunately_expired', user: user_a )
      visit login_path
      fill_in 'メールアドレス', with: user_a.email
      fill_in 'パスワード', with: user_a.password
      find(".btn-login").click
    end

    describe '商品・食材の新規登録ができる' do
      before { login_as(user_a) }
        context 'フォームの入力値が正常である時' do
            it '商品・食材の新規作成が成功する' do
              visit new_item_path
              fill_in '商品名', with: 'こんにちは'
              fill_in '数', with: '22'
              fill_in '賞味期限', with: DateTime.new(2030, 5, 5)
              fill_in 'item[detail]', with: 'test-test-test'
              click_on '登録'
              expect(current_path).to eq items_path
              expect(page).to have_content '商品・食材を作成しました'
              expect(page).to have_content 'こんにちは'
              expect(page).to have_content '数:22'
              expect(page).to have_content '2030-05-05'
            end

            it '食材テンプレートの使用が成功する' do
              visit new_item_path
              find("option[value='刺身']").select_option
              fill_in '賞味期限', with: DateTime.new(2030, 5, 5)
              click_on '登録'
              expect(current_path).to eq items_path
              expect(page).to have_content '刺身'
            end
        end

        context 'フォームの入力値に異常がある時' do
            it '商品名不足で登録できない' do
              visit new_item_path
              fill_in '商品名', with: ''
              fill_in '数', with: '22'
              fill_in '賞味期限', with: DateTime.new(2030, 5, 5)
              fill_in 'item[detail]', with: 'test-test-test'
              click_on '登録'
              expect(current_path).to eq items_path
            end

            it '数不足登録できない' do
              visit new_item_path
              fill_in '商品名', with: '数がないよ'
              fill_in '数', with: ''
              fill_in '賞味期限', with: DateTime.new(2030, 5, 5)
              fill_in 'item[detail]', with: 'test-test-test'
              click_on '登録'
              expect(current_path).to eq items_path
            end

            it '賞味期限不足で登録できない' do
              visit new_item_path
              fill_in '商品名', with: '賞味期限がなくて登録できない'
              fill_in '数', with: '22'
              fill_in '賞味期限', with: ''
              fill_in 'item[detail]', with: 'test-test-test'
              click_on '登録'
              expect(current_path).to eq items_path
            end
        end

        context 'ゲストユーザーは合計で3つまでしか商品を登録できない' do
          before do
            visit login_path
            click_link 'ゲストログイン'
          end

          it '２つ以下であれば商品を登録することができる' do
            register_multiple_items(2)
            visit items_path
            expect(page).to have_content 'コーヒー2'
            expect(page).to have_content 'コーヒー1'
            expect(page).to have_content '数:22'
          end

          it '３つ以上は商品を登録できない' do
            register_multiple_items(3)
            expect(current_path).to eq items_path
            expect(page).to have_content 'ゲストユーザーは3つまでしかアイテムを登録できません。'
          end
        end
    end

    describe 'Itemが編集と削除' do
      before { login_as(user_a); item_register(item_c) }
      it 'Itemが編集できる' do
        visit items_path
        page.all(".fa-pen")[1].click
        visit edit_item_path(item_c)
        fill_in '商品名', with: 'test'
        fill_in '数', with: '3'
        fill_in '賞味期限', with: DateTime.new(2050, 5, 5)
        fill_in 'item[detail]', with: 'test-test-test'
        click_on '登録'
        expect(current_path).to eq items_path
        expect(page).to have_content 'test'
        expect(page).to have_content '3'
      end

      it 'Itemを削除できる' do
        visit items_path
        page.all(".fa-eraser")[1].click
        expect(page.accept_confirm).to eq '削除しますか？'
        expect(page).to have_content '削除しました'
      end
    end

    describe 'Item/index内の表示' do
      before { login_as(user_a); item_register(item_c)}
      context '商品・食材がモーダル表記できる時' do
        it '商品・食材の詳細モーダルページが表示される', js: true do
          visit items_path
          find('.item-modal-trigger', match: :first).click
          expect(page).to have_content '最初の商品'
          expect(page).to have_content '数:2個'
          expect(page).to have_content '2030-05-05'
          expect(page).to have_content 'test_words'
          click_link '冷蔵庫の中身に戻る'
          expect(current_path).to eq items_path
        end
      end

      context '賞味期限切れへの切り替えができる時' do
        it 'ボタンを押して賞味期限切れの商品・食材を表示できる' do
          visit items_path
          click_link '賞味期限切れ'
          expect(page).to have_content '期限切れ'
          expect(page).to have_content '数:32'
          expect(page).to have_content '2000-05-05'
          expect(page).to have_content '期限切れです'
          expect(current_path).to eq already_expired_items_path
        end
      end

      context '賞味期限切れでもモーダル表記できる時' do
        it '商品・食材の詳細モーダルページが表示される', js: true do
          visit already_expired_items_path
          find('.item-modal-trigger').click
          expect(page).to have_content '期限切れ'
          expect(page).to have_content '数:32個'
          expect(page).to have_content '2000-05-05'
          expect(page).to have_content 'Unfortunately_expired'
          click_link '冷蔵庫の中身に戻る'
          expect(current_path).to eq items_path
        end
      end

      context 'indexから数の増減ができる' do
        it '+ボタンを押すことで数を1つ増やせる' do
          visit items_path
          click_button('+', match: :first)
          expect(page).to have_content '数:3'
        end

        it '-ボタンを押すことで数を一つ減らせる' do
          visit items_path
          click_button('-', match: :first)
          expect(page).to have_content '数:1'
        end
      end

      context '検索欄から検索できる時' do
        it '最初の商品を検索できる' do
          visit items_path
          fill_in 'q[title]', with: '最初の商品'
          find('.btn.btn-default').click
          expect(current_path).to eq search_items_path
          expect(page).to have_content '最初の商品'
          expect(page).to have_content '数:2'
          expect(page).to have_content '2030-05-05'
        end
      end
    end
end
