# Users
u = User.create(username: 'damianfarina', password: 'password')

# Tasks
u.add_task(Task.new({
  description: 'Description',
  category: 'personal',
  due_date: Date.today
}))
