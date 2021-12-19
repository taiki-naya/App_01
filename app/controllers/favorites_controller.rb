class FavoritesController < ApplicationController
  def create
    if params[:store].present?
      favorite = current_user.favorites.create(favoritable_type: 'Store', favoritable_id: params[:store])
      redirect_to store_path(id: params[:store]), notice: "#{favorite.favoritable.name}をお気に入り登録しました"
    elsif params[:league].present? && params[:team].present?
      favorite = current_user.favorites.create(favoritable_type: 'Team', favoritable_id: params[:team])
      redirect_to league_team_path(league_id: params[:league], id: params[:team]), notice: "#{favorite.favoritable.name}をお気に入り登録しました"
    elsif params[:league].present?
      favorite = current_user.favorites.create(favoritable_type: 'League', favoritable_id: params[:league])
      redirect_to league_path(id: params[:league]), notice: "#{favorite.favoritable.name}をお気に入り登録しました"
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:favorite]).destroy
    redirect_to store_path, notice: "#{favorite.favoritable.name}をお気に入り解除しました" if favorite.favoritable_type == 'Store'
    redirect_to league_path, notice: "#{favorite.favoritable.name}をお気に入り解除しました" if favorite.favoritable_type == 'League'
    redirect_to league_team_path(league_id: favorite.favoritable.league_id, id: params[:id] ), notice: "#{favorite.favoritable.name}をお気に入り解除しました" if favorite.favoritable_type == 'Team'
  end
end
