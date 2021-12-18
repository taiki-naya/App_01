class KitsController < ApplicationController

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
    params.require(:kit).permit(:series, :team_id)
  end

end
