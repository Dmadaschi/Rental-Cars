require 'rails_helper'

feature 'Validates subsidiary access' do
  context 'Admin singed in and' do
    scenario 'view index' do
      user = create(:user)

      login_as(user, scope: :user)
      visit subsidiaries_path

      expect(current_path).to eq(subsidiaries_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view new' do
      user = create(:user)

      login_as(user, scope: :user)
      visit new_subsidiary_path

      expect(current_path).to eq(new_subsidiary_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view edit' do
      user = create(:user)
      subsidiary = create(:subsidiary)

      login_as(user, scope: :user)
      visit edit_subsidiary_path(subsidiary)

      expect(current_path).to eq(edit_subsidiary_path(subsidiary.id))
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view show' do
      user = create(:user)
      subsidiary = create(:subsidiary)

      login_as(user, scope: :user)
      visit subsidiary_path(subsidiary)

      expect(current_path).to eq(subsidiary_path(subsidiary))
      expect(current_path).not_to eq(new_user_session_path)
    end
  end

  context 'Admin not singed in and do not' do
    scenario 'view index' do
      visit subsidiaries_path

      expect(current_path).not_to eq(subsidiaries_path)
      expect(current_path).to eq(new_user_session_path)
    end
    scenario 'view new' do
      visit new_subsidiary_path

      expect(current_path).not_to eq(new_subsidiary_path)
      expect(current_path).to eq(new_user_session_path)
    end
    scenario 'view edit' do
      subsidiary = create(:subsidiary)

      visit edit_subsidiary_path(subsidiary)

      expect(current_path).not_to eq(edit_subsidiary_path(subsidiary.id))
      expect(current_path).to eq(new_user_session_path)
    end
    scenario 'view show' do
      subsidiary = create(:subsidiary)

      visit subsidiary_path(subsidiary)

      expect(current_path).not_to eq(subsidiary_path(subsidiary))
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
