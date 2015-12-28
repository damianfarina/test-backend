class Task < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:description, :user_id]
  end
end
