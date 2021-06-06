require 'openssl'
require 'base64'

module Serket
    # Used to encrypt a field given a public key, field delimiter, symmetric
    # algorithm, encoding and format (:json or :delimited)
    class FieldEncrypter
        attr_accessor :field_delimiter, :public_key_filepath, :symmetric_algorithm, :encoding, :dummy_public_key_path, :dummy_password

        def initialize(options = {})
            options ||= {}

            @public_key_filepath    = Serket.configuration.public_key_path
            @dummy_public_key_path  = Serket.configuration.dummy_public_key_path
            @dummy_password         = Serket.configuration.dummy_password
            @field_delimiter        = options[:field_delimiter]     || Serket.configuration.delimiter 
            @symmetric_algorithm    = options[:symmetric_algorithm] || Serket.configuration.symmetric_algorithm
            @format                 = options[:format]              || Serket.configuration.format
            @encoding               = options[:encoding]            || Serket.configuration.encoding
        end

        # Return encrypted string according to specified format.
        # Return nil if field is whitespace.
        def encrypt(field, key_path, pass)
            return if field !~ /\S/
            aes = OpenSSL::Cipher.new(symmetric_algorithm)
            aes_key = aes.random_key
            iv = aes.random_iv
            encrypt_data(iv, aes_key, field.force_encoding(encoding), key_path, pass)
        end

        # Allow any field delimiter except a base64 character.
        def field_delimiter=(delimiter)
            if delimiter =~ /[A-Za-z0-9\/+]/
                raise "This is not a valid delimiter!  Must not be a character in Base64."
            end

            @field_delimiter = delimiter
        end

        private
        def encrypt_data(iv, key, text, key_path, pass)
            public_key = OpenSSL::PKey::RSA.new(File.read(key_path), pass)
            encrypted_aes_key = public_key.public_encrypt(key)

            aes = OpenSSL::Cipher.new(symmetric_algorithm)
            aes.encrypt
            aes.key = key
            aes.iv = iv
            encrypted_text = aes.update(text) + aes.final

            parse(Base64.encode64(iv), Base64.encode64(encrypted_aes_key), Base64.encode64(encrypted_text))
        end

        # Format the final encrypted string to be returned depending
        # on specified format.
        def parse(iv, encrypted_key, encrypted_text)
            case @format
            when :delimited
                #[iv, field_delimiter, encrypted_key, field_delimiter, encrypted_text].join('')
                hash = {}
                hash['iv'] = iv
                hash['key'] = encrypted_key
                hash['message'] = encrypted_text
                hash.to_json
            when :json
                hash = {}
                hash['iv'] = iv
                hash['key'] = encrypted_key
                hash['message'] = encrypted_text
                hash.to_json
            end
        end
    end
end
