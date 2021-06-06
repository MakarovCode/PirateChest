module Treasure
    module Api
        module V1
            class FoldersController < Treasure::Api::V1::ApplicationController

                acts_as_token_authentication_handler_for User

                def index 
                    @folders = current_user.folders.order("name ASC")
                end

                def create
                    params.permit!
                    folder = current_user.folders.new params[:folder]

                    if folder.save
                        render status: 200, json: {message: "Folder successfully created!"}
                    else
                        render status: 411, json: {message: folder.errors.full_messages}
                    end
                end

                def update 
                    params.permit!
                    folder = Folder.find params[:id]

                    if folder.update params[:folder]
                        render status: 200, json: {message: "Folder successfully updated!"}
                    else
                        render status: 411, json: {message: folder.errors.full_messages}
                    end
                end

                def destroy
                    folder = Folder.find params[:id]

                    if folder.destroy
                        render status: 200, json: {message: "Folder successfully destroyed!"}
                    else
                        render status: 411, json: {message: folder.errors.full_messages}
                    end
                end

            end
        end
    end
end