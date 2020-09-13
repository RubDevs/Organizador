class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include AASM

  field :name, type: String
  field :description, type: String
  field :due_date, type: Date
  field :role, type: Integer
  field :status, type: String
  field :transitions, type: Array, default: []

  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  #has_many :participants, through: :participating_users, source: :user
  has_many :notes
  after_create :send_email

  validates :participating_users, presence: true
  validates :name, :description, presence:true
  validates :name, uniqueness:{case_insensitive: false}
  validate :due_date_validity

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  aasm column: :status do
    state :pending, initial: true
    state :in_process, :finished

    after_all_transitions :audit_status_change

    event :start do
      transitions from: :pending, to: :in_process
    end

    event :finish do
      transitions from: :in_process, to: :finished
    end
  end

  def audit_status_change
    set transitions: transitions.push(
      {
        from_state: aasm.from_state,
        to_state: aasm.to_state,
        current_event: aasm.current_event,
        timestamp: Time.zone.now
      }
    )
  end

  def participants
    participating_users.includes(:user).map(&:user)
  end

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.error.invalid_due_date')
  end

  def send_email
    return unless Rails.env.development?
    Tasks::SendEmailJob.perform_async self.id.to_s
  end
end
