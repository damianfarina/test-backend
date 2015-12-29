require 'date'
require_relative 'todo/display'
require_relative 'todo/events'
require_relative 'todo/server'

class TestApp
  module Components
    class Todo < Wedge::Component
      name :todo

      CATEGORIES = %w`personal work school cleaning other`

      include TodoDisplay
      include TodoServer

      wedge_on_server TodoServer

      # html is from http://codepen.io/yesimaaron/pen/JGHlq
      html './public/todo.html' do
        head    = dom.find('head')
        html    = dom.find('html')
        content = dom.find('.content')

        head.append stylesheet_tag 'app'
        head.append stylesheet_tag 'todo'
        html.append javascript_tag 'app'

        content.find('> h1').html 'Todo App'
        content.find('> p').html 'ACD - Backend Test'

        categories_select = dom.find('#category')

        categories_select.find('option').attr 'selected', 'selected'

        CATEGORIES.each do |category|
          categories_select.append html! {
            option category.titleize, value: category
          }
        end

        tmpl :task_item, dom.find('.taskItem')
      end

      def add_task task_id, description, category, date_str, read = false
        task_list_dom = dom.find('ul.taskList')
        task_item     = tmpl :task_item

        # ID
        task_item.add_class "task-id-#{task_id}"

        # Description
        description_dom = task_item.find('.description')
        description_dom.html description
        description_dom.add_class "read-#{read}"

        # Category
        category_dom = task_item.find('.category')
        category_dom.html category
        category_dom.add_class "category-#{category}"

        # Date
        date_dom = task_item.find('.date')
        due_date = Date.parse(date_str)
        date_dom.html due_date.strftime('%m/%d/%Y')
        date_dom.add_class "read-#{read}"

        task_list_dom.append task_item
      end
    end
  end
end
