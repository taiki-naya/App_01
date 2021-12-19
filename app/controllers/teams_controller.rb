class TeamsController < ApplicationController

  def index
    @league = League.find(params[:league_id])
    @teams  = @league.teams
  end

  def show
    @team = Team.find(params[:id])
    @favorite = current_user.favorites.find_by(favoritable_type: 'Team', favoritable_id: @team.id) if current_user.present?
  end

  def new
    @league = League.find(params[:league_id])
    @team   = Team.new
  end

  def edit
    @team   = Team.find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    @league = League.find(params[:league_id])
    @team.league_id = @league.id
    if @team.save
      redirect_to league_teams_path, notice: 'Team was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def import
    @league = League.find(params[:league_id])
    Team.import(params[:file], params[:league_id])
    redirect_to league_teams_path, notice: 'Teams was successfully created by a CSV file.'
  end

  def update
    @team = Team.find(params[:id])
      if @team.update(team_params)
        redirect_to league_team_path, notice: "Team was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to league_teams_path, notice: 'Team was successfully destroyed.'
  end

  private
  def team_params
    params.require(:team).permit(:name, :home_town, :established, :description, :image)
  end

end
