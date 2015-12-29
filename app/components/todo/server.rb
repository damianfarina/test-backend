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

      def get_tasks all_tasks = false
        tasks = all_tasks ? Task : current_user.tasks
        {
          tasks: tasks.map do |task|
            {
              id: task.id,
              description: task.description,
              category: task.category,
              due_date: task.due_date,
              is_read: current_user.read_tasks.include?(task),
              is_deletable: current_user.tasks.include?(task)
            }
          end
        }
      end

      def delete_tasks task_ids
        current_user.tasks_dataset.where(id: task_ids).delete
        { success: true }
      end

      def read_task task_id
        user_read_tasks = current_user.read_tasks
        selected_tasks = Task.where(id: task_id).all
        new_read_tasks = selected_tasks - user_read_tasks
        new_read_tasks.each do |task|
          current_user.add_read_task task
        end
        { success: true }
      end
    end
  end
end
