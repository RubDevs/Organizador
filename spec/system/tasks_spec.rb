require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create :user }
  before(:each) { sign_in user }

  before do
    driven_by(:rack_test)
  end

  describe 'GET /tasks' do
    it 'it has the correct title' do
      visit '/tasks'
      expect(page).to have_content 'Lista de Tareas'
    end
  end

  describe 'POST /tasks' do
    let!(:category) { create :category }
    it 'Creates a new task' do
      visit '/tasks/new'
      fill_in 'task[name]', with: 'Test '
      fill_in 'task[description]', with: 'Desc '
      fill_in 'task[due_date]', with: Date.today + 5.days
      select category.name, from: 'task[category_id]'
      #expect(page).to have_content 'Lista de Tareas'
    end
  end
end
