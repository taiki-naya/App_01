class ProfilesController < ApplicationController

  def show
      @user = User.find(params[:id])
      redirect_to root_path, notice: "閲覧権限がありません" unless (user_signed_in? && @user == current_user) || current_user&.admin?
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to profile_path(id: @profile.user.id), notice: 'プロフィールが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :introduction, :jid, :image)
  end
end
