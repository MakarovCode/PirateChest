module Treasure
    class BaseController < ApplicationController
        layout 'treasure/layouts/application'

        before_action :authenticate_user!
    end
end
