object @users

attributes :id, :username, :email

node :value do |user|
    user.email
end