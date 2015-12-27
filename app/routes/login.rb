TestApp.route('login') do |r|
  r.root do
    if current_user
      r.redirect '/'
    else
      wedge(:login).to_js :display
    end
  end
end
