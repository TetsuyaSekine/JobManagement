class ShainsController < ApplicationController
  before_action :set_shain, only: [:show, :edit, :update, :destroy]

  # GET /shains
  # GET /shains.json
  def index
    @shains = Shain.all
  end

  # GET /shains/1
  # GET /shains/1.json
  def show
  end

  # GET /shains/new
  def new
    @shain = Shain.new
  end

  # GET /shains/1/edit
  def edit
  end

  # POST /shains
  # POST /shains.json
  def create
    @shain = Shain.new(shain_params)

    respond_to do |format|
      if @shain.save
        format.html { redirect_to @shain, notice: 'Shain was successfully created.' }
        format.json { render :show, status: :created, location: @shain }
      else
        format.html { render :new }
        format.json { render json: @shain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shains/1
  # PATCH/PUT /shains/1.json
  def update
    respond_to do |format|
      if @shain.update(shain_params)
        format.html { redirect_to @shain, notice: 'Shain was successfully updated.' }
        format.json { render :show, status: :ok, location: @shain }
      else
        format.html { render :edit }
        format.json { render json: @shain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shains/1
  # DELETE /shains/1.json
  def destroy
    @shain.destroy
    respond_to do |format|
      format.html { redirect_to shains_url, notice: 'Shain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shain
      @shain = Shain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shain_params
      params.require(:shain).permit(:shain_id, :name, :section, :pb, :group, :grade, :email, :charge, :del_flg)
    end
end
