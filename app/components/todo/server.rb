class TestApp
  module Components
    module TodoServer
      def get_tasks
        {
          tasks: current_user.tasks.map do |task|
            {
              id: task.id,
              description: task.description,
              category: task.category,
              due_date: task.due_date
            }
          end
        }
      end
    end
  end
end
