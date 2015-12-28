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
    end
  end
end
