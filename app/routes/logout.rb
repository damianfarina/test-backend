TestApp.route('logout') do |r|
  r.root do
    logout User
    r.redirect '/login'
  end
end
