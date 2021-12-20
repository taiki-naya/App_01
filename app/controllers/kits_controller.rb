class KitsController < ApplicationController
  before_action :access_restriction, except: [:show]

  def index
    @league = League.find(params[:league_id])
    @team   = Team.find(params[:team_id])
    @kits   = @team.kits
  end

  def show
    @kit = Kit.find(params[:id])
    @item = @kit.labelling_of_items.order(updated_at: :desc).limit(8)
  end

  def new
    @league = League.find(params[:league_id])
    @team   = Team.find(params[:team_id])
    @kit    = Kit.new
  end

  def edit
    @kit = Kit.find(params[:id])
  end

  def create
    @kit  = Kit.new(kit_params)
    @league = League.find(params[:league_id])
    @team = Team.find(params[:team_id])
    @kit.team_id = @team.id
    if @kit.save
      redirect_to league_team_kits_path, notice: "Kit was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @kit = Kit.find(params[:id])
    if @kit.update(kit_params)
      redirect_to league_team_kit_path, notice: "Kit was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kit = Kit.find(params[:id])
    @kit.destroy
    redirect_to league_team_kits_path, notice: "Kit was successfully destroyed."
  end

  private
  def kit_params
    params.require(:kit).permit(:series, :team_id, :image)
  end


  def access_restriction
    redirect_to root_path, notice: '権限がありません。' unless user_signed_in? || current_user&.admin?
  end

end
