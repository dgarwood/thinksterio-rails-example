json.user do |json|
  json.partial! 'user/user', user: current_user
end
