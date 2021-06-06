class Password < ApplicationRecord
    belongs_to :folder
    has_many :password_users, dependent: :destroy
    has_many :users, through: :password_users

    before_save :encrypt_data

    validates :name, :login, :pass, :folder_id, presence: true

    def encrypt_data
        key_path = "#{Rails.root.join('certificates', 'users')}/#{self.folder.user_id}/public_key.pem" if Rails.env == "development"
        key_path = "/home/rails/piratechest/shared/certificates/users/#{self.folder.user_id}/public_key.pem" if Rails.env == "production"

        self.login = Serket.encrypt(self.login, key_path, self.folder.user.email)
        self.pass = Serket.encrypt(self.pass, key_path, self.folder.user.email)

        self.url = Serket.encrypt(self.url, key_path, self.folder.user.email) unless self.url.nil?
        self.notes = Serket.encrypt(self.notes, key_path, self.folder.user.email) unless self.notes.nil?
    end

    def decrypted_login
        Serket.decrypt(self.login, private_key_path, self.folder.user.email)
    end

    def decrypted_pass
        Serket.decrypt(self.pass, private_key_path, self.folder.user.email)
    end

    def decrypted_url
        Serket.decrypt(self.url, private_key_path, self.folder.user.email)
    end

    def decrypted_notes
        #Serket.decrypt(self.notes, private_key_path, self.folder.user.email)
    end

    def private_key_path
        key_path = "#{Rails.root.join('certificates', 'users')}/#{self.folder.user_id}/private_key.pem" if Rails.env == "development"
        key_path = "/home/rails/piratechest/shared/certificates/users/#{self.folder.user_id}/private_key.pem" if Rails.env == "production"
        key_path
    end
end
