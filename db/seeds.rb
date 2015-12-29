# Users
u = User.create(username: 'test1', password: 'password')

# Tasks
(1..10).step(2) do |i|
  t = Task.new({
    description: "Description 1-#{i}",
    category: 'personal',
    due_date: Date.today
  })
  u.add_task t
  u.add_read_task t
  u.add_task({
    description: "Description 1-#{i + 1}",
    category: 'school',
    due_date: Date.today
  })
end

# Users
u = User.create(username: 'test2', password: 'password')

# Tasks
(1..10).step(2) do |i|
  t = Task.new({
    description: "Description 2-#{i}",
    category: 'personal',
    due_date: Date.today
  })
  u.add_task t
  u.add_read_task t
  u.add_task({
    description: "Description 2-#{i + 1}",
    category: 'school',
    due_date: Date.today
  })
end
