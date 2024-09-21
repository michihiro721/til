class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to boards_path, success: t('user_sessions.create.success')  # ログイン後 /boards にリダイレクト
    else
      flash.now[:danger] = t('user_sessions.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = t('user_sessions.destroy.success') # ログアウト時のフラッシュメッセージを追加
    redirect_to root_path, status: :see_other  # ログアウト時は root_path へ
  end
end
