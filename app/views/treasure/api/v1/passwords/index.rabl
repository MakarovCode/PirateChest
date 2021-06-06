object @folders

attributes :id, :name

node :login do |password|
    password.decrypted_login
end

node :pass do |password|
    password.decrypted_pass
end

node :url do |password|
    password.decrypted_url
end

node :notes do |password|
    password.decrypted_notes
end

child password_users: :shares do 
    attributes :id, :permissions
    
    child :user do
        attributes :name, :username, :email
    end
end
