module Treasure
    module Api
        module V1
            class UsersController < Treasure::Api::V1::ApplicationController

                acts_as_token_authentication_handler_for User

                def index
                    if params[:term]
                        if params[:term].to_s.size >= 4
                            @users = User.by_term(params[:term], current_user.id).order("username ASC")
                        else
                            @users = []
                        end
                    else
                        @users = []
                    end
                end

            end
        end
    end
end
