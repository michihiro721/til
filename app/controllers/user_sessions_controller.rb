class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, success: t('user_sessions.create.success')  # ここを root_path に変更
    else
      flash.now[:danger] = t('user_sessions.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = t('user_sessions.destroy.success')  # ログアウト時のフラッシュメッセージを追加
    redirect_to root_path, status: :see_other  # ここも root_path に変更
  end
end
