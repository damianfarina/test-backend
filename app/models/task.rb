class Task < Sequel::Model
  plugin :validation_helpers
  
  many_to_one :owner, class: :User, key: :user_id

  def validate
    super
    validates_presence [:description, :user_id]
  end
end
