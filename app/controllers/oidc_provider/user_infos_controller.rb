# frozen_string_literal: true

module OIDCProvider
  class UserInfosController < ApplicationController
    before_action :require_access_token

    def show
      render json: user_info.to_json.merge({is_active: account.employee.active?})
    end

    private

    def user_info
      AccountToUserInfo.new(authorization.user_info_scopes)
                       .call(account)
    end

    def account
      @account ||= authorization.account
    end

    def authorization
      @authorization ||= current_token.authorization
    end
  end
end
