require_relative '../../forms/task'

if RUBY_ENGINE == 'opal'
  class Element
    alias_native :datepicker
  end
end

class TestApp
  module Components
    class Todo < Wedge::Component
      name :todo

      on :ready do
        dom.find('input.taskDate').datepicker(`{dateFormat: 'yy-mm-dd'}`)

        get_tasks do |res|
          res[:tasks].each do |task|
            add_task task[:id], task[:description], task[:category], task[:due_date], task[:read]
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

      on :click, '.taskDelete' do |el, evt|
        evt.prevent_default
        tasks_to_delete = []
        checkboxes = dom.find('.taskCheckbox[type=checkbox]:checked')
        checkboxes.each do |checkbox|
          tasks_to_delete << get_task_id(checkbox)
        end
        delete_tasks tasks_to_delete do |res|
          remove_dom_tasks checkboxes if res[:success]
        end
      end

      on :click, '.taskRead' do |el, evt|
        evt.prevent_default
        tasks_to_read = []
        checkboxes = dom.find('.taskCheckbox[type=checkbox]:checked')
        checkboxes.each do |checkbox|
          tasks_to_read << get_task_id(checkbox)
        end

        read_tasks tasks_to_read do |res|
          mark_tasks_read tasks_to_read if res[:success]
        end
      end

      def disable_submit form_element, class_name
        button = form_element.find("button.#{class_name}")
        button.prop("disabled", true)
      end

      def enable_submit form_element, class_name
        button = form_element.find("button.#{class_name}")
        button.prop("disabled", false)
      end

      def clear_fields form_element
        form_element.find('input[name="task[description]"]').value = ''
        form_element.find('select[name="task[category]"]').value = ''
        form_element.find('input[name="task[due_date]"]').value = ''
      end

      def get_task_id element
        element.closest('.taskItem')
          .attr('class')
          .split('task-id-')[1]
      end

      def remove_dom_tasks elements
        elements.closest('.taskItem').remove
      end

      def mark_tasks_read task_ids
        task_ids.each do |task_id|
           dom.find(".task-id-#{task_id} .description, .task-id-#{task_id} .date")
            .remove_class("read-false")
            .add_class("read-true")
        end
      end
    end
  end
end
