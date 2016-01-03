class User < Sequel::Model
  include Shield::Model

  one_to_many :tasks
  many_to_many :read_tasks, join_table: :tasks_users, class: :Task,
    left_key: :user_id, right_key: :task_id

  plugin :validation_helpers
  plugin :association_dependencies, tasks: :destroy, read_tasks: :nullify

  def self.fetch(username)
    find(:username => username)
  end

  def validate
    super
    validates_presence [:username, :crypted_password]
    validates_unique :username
  end
end
