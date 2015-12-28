class TaskCreator
  def self.run user, task_attrs
    task = Task.new
    task.description = task_attrs[:description]
    task.category = task_attrs[:category]
    task.due_date = task_attrs[:due_date]

    user.add_task task
    task
  end
end
