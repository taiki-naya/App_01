class StoresController < ApplicationController
  before_action :access_restriction, except: [:index, :show]
  def index
    @stores = Store.all.page(params[:page]).per(10)
  end

  def show
    @store = Store.find(params[:id])
    @items  = @store.items.order(created_at: :desc).limit(8)
    @favorite = current_user.favorites.find_by(favoritable_type: 'Store', favoritable_id: @store.id) if current_user.present?
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    @store = Store.new(store_params)
    unless @store.link.present?
      @store.link = 'https://temprary-url'
      @store.save
      @store.update_attribute(:link, '')
      redirect_to @store, notice: 'ストア情報が作成されました。'
    else
      if @store.save
        redirect_to @store, notice: 'Stores was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to stores_path, notice: 'Store was successfully destroyed.'
  end

  private
  def store_params
    params.require(:store).permit(:name, :link, :address, :note)
  end
  def access_restriction
    redirect_to root_path, notice: '権限がありません。' unless user_signed_in? || current_user&.admin?
  end

end
