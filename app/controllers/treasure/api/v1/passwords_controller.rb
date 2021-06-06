module Treasure
    module Api
        module V1
            class PasswordsController < Treasure::Api::V1::ApplicationController

                acts_as_token_authentication_handler_for User

                before_action :get_folder

                def get_folder
                    @folder = Folder.find params[:folder_id]
                end

                def index
                    @passwords = Password.all.order("name ASC")
                end

                def create
                    params.permit!
                    password = @folder.passwords.new params[:password]

                    if password.save
                        render status: 200, json: {message: "Password successfully created!"}
                    else
                        render status: 411, json: {message: password.errors.full_messages}
                    end
                end

                def update
                    params.permit!
                    password = Password.find params[:id]

                    if password.update params[:password]
                        render status: 200, json: {message: "Password successfully updated!"}
                    else
                        render status: 411, json: {message: password.errors.full_messages}
                    end
                end

                def destroy
                    password = Password.find params[:id]

                    if password.destroy
                        render status: 200, json: {message: "Password successfully destroyed!"}
                    else
                        render status: 411, json: {message: password.errors.full_messages}
                    end
                end

            end
        end
    end
end
