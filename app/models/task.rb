# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user

  after_create :send_email

  validates :participating_users, presence: true
  validates :name, :description, presence:true
  validates :name, uniqueness:{case_insensitive: false}
  validate :due_date_validity

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.error.invalid_due_date')
  end

  def send_email
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user,task: self).new_task_email.deliver!
    end
  end
end
