class TestApp
  module Components
    class Todo < Wedge::Component
      name :todo

      on :ready do
        get_tasks do |res|
          res[:tasks].each do |task|
            add_task task[:id], task[:description], task[:category], task[:due_date]
          end
        end
      end

      def add_task task_id, description, category, date_str, complete = false
        task_list_dom = dom.find('ul.taskList')
        task_item     = tmpl :task_item

        # Description
        description_dom = task_item.find('.description')
        description_dom.html description
        description_dom.add_class "complete-#{complete}"

        # Category
        category_dom = task_item.find('.category')
        category_dom.html category
        category_dom.add_class "category-#{category}"

        # Date
        date_dom = task_item.find('.date')
        due_date = Date.parse(date_str)
        date_dom.html due_date.strftime('%m/%d/%Y')
        date_dom.add_class "complete-#{complete}"

        task_list_dom.append task_item
      end
    end
  end
end
