Sequel.migration do
  change do
    create_table :tasks_users do
      foreign_key :task_id, :tasks
      foreign_key :user_id, :users
    end
  end
end
