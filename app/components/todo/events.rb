require_relative '../../forms/task'

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

      on :submit, '#task-form', form: :task_form, key: :task do |form, el|
        disable_submit el, 'taskAdd'

        begin
          if form.valid?
            save_task form.attributes do |res|
              if res[:success]
                add_task res[:task][:id], form.description, form.category, form.due_date
                clear_fields el
              else
                form.display_errors errors: res[:errors]
              end
            end
          else
            form.display_errors
          end
        ensure
          enable_submit el, 'taskAdd'
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

      def disable_submit form_element, class_name
        button = form_element.find('button.' + class_name)
        button.prop("disabled", true)
      end

      def enable_submit form_element, class_name
        button = form_element.find('button.' + class_name)
        button.prop("disabled", false)
      end

      def clear_fields form_element
        form_element.find('input[name="task[description]"]').value = ''
        form_element.find('select[name="task[category]"]').value = ''
        form_element.find('input[name="task[due_date]"]').value = ''
      end
    end
  end
end
