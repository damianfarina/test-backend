class Task < Sequel::Model
  plugin :validation_helpers

  many_to_one :owner, class: :User, key: :user_id
  many_to_many :readers, join_table: :tasks_users, class: :User,
    left_key: :task_id, right_key: :user_id

  plugin :association_dependencies, readers: :nullify

  def validate
    super
    validates_presence [:description, :user_id]
  end
end
