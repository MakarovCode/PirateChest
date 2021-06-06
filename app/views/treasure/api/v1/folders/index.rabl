object @folders

attributes :id, :name

node :owner do |folder|
    if folder.user == current_user
        "You"
    else
        folder.user.username
    end
end

node :created_at do |folder|
    l folder.updated_at, format: :short
end

child :passwords do
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
end