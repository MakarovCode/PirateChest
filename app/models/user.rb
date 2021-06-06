class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable

    acts_as_token_authenticatable

    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable

    has_many :folders, dependent: :destroy
    has_many :password_users, dependent: :destroy
    has_many :shared_passwords, through: :password_users, class_name: "Password", foreign_key: "password_id"

    after_create :generate_keys

    def generate_keys
      if Rails.env == "development"
        system "cd #{Rails.root.join('certificates/users')} && mkdir #{self.id} && cd #{self.id} && ssh-keygen -t rsa -b 2048 -v -f private_key.pem -N #{self.email} && openssl rsa -in private_key.pem -pubout -out public_key.pem -passin pass:#{self.email}"
      else
        system "cd /home/rails/piratechest/shared/certificates/users && mkdir #{self.id} && cd #{self.id} && ssh-keygen -t rsa -b 2048 -m PEM -v -f private_key.pem -N #{self.email} && openssl rsa -in private_key.pem -pubout -out public_key.pem -passin pass:#{self.email}"
      end
    end

    def self.by_term(term, id)
        where("email iLIKE '%#{term}%' OR username iLIKE '%#{term}%' AND id != ?", id)
    end
end
#
"cd /home/rails/piratechest/shared/certificates/users && mkdir #{u.id} && cd #{u.id} && ssh-keygen -t rsa -b 2048 -m PEM -v -f private_key.pem -N #{u.email} && openssl rsa -in private_key.pem -pubout -out public_key.pem -passin pass:#{u.email}"
