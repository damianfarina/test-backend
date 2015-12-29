class TestApp
  module Components
    module TodoServer
      def save_task form
        task = TaskCreator.run(current_user, form)
        if task.errors.any?
          { success: false, errors: task.errors }
        else
          { success: true, task: { id: task.id } }
        end
      end

      def get_tasks
        {
          tasks: current_user.tasks.map do |task|
            {
              id: task.id,
              description: task.description,
              category: task.category,
              due_date: task.due_date,
              read: current_user.read_tasks.include?(task)
            }
          end
        }
      end

      def delete_tasks task_ids
        current_user.tasks_dataset.where(id: task_ids).delete
        { success: true }
      end

      def read_tasks task_ids
        user_read_tasks = current_user.read_tasks
        selected_tasks = Task.where(id: task_ids).all
        new_read_tasks = selected_tasks - user_read_tasks
        new_read_tasks.each do |task|
          current_user.add_read_task task
        end
        { success: true }
      end
    end
  end
end
