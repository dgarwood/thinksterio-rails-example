json.(user, :id, :email, :username, :bio, :image)
json.token user.generate_jwt
json.following signed_in? ? current_user.following?(user) : false
