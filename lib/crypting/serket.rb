require_relative "./serket/version"
require_relative "./serket/field_decrypter.rb"
require_relative "./serket/field_encrypter.rb"
require_relative "./serket/decrypted_fields.rb"
require_relative "./serket/encrypted_fields.rb"
require_relative "./serket/configuration.rb"

module Serket
    class << self
        attr_writer :configuration
    end

    def self.configuration
        @configuration ||= Configuration.new
    end

    def self.configure
        yield(configuration)
    end

    def self.encrypt(text, key_path, pass)
        field_encrypter.encrypt(text, key_path, pass)
    end

    def self.decrypt(cipher, key_path, pass)
        field_decrypter.decrypt(cipher, key_path, pass)
    end

    def self.field_encrypter
        @field_encrypter ||= FieldEncrypter.new
    end

    def self.field_decrypter
        @field_decrypter ||= FieldDecrypter.new
    end
end
