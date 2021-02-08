class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  before_action :ensure_login, only: [:my_artworks, :new, :edit, :create, :update, :destroy]

  # GET /artworks
  # GET /artworks.json

  def index
    @artworks = Artwork.search(params[:keyword])
  end

  def my_artworks
    @artworks = Artwork.where(user_id: current_user.id)
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
  end

  # GET /artworks/new
  def new
    @artwork = Artwork.new
  end

  # GET /artworks/1/edit
  def edit
  end

  # POST /artworks
  # POST /artworks.json
  def create
    a = artwork_params
    a['user_id'] = current_user.id

    @artwork = Artwork.new(a)

    respond_to do |format|
      if @artwork.save
        format.html { redirect_to @artwork, notice: 'Artwork was successfully created.'}
        format.json { render :show, status: :created, location: @artwork }
      else
        format.html { render :new, notice: @artwork.errors }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artworks/1
  # PATCH/PUT /artworks/1.json
  def update
    respond_to do |format|
      if @artwork.update(artwork_params)
        format.html { redirect_to @artwork, notice: 'Artwork was successfully updated.' }
        format.json { render :show, status: :ok, location: @artwork }
      else
        format.html { render :edit }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artworks/1
  # DELETE /artworks/1.json
  def destroy
    @artwork.destroy
    respond_to do |format|
      format.html { redirect_to artworks_url, notice: 'Artwork was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    if request.xhr?
      dl_artw = Artwork.find(params[:id])

      if params[:option] == 'free'
        img_url = dl_artw.image.service_url

        transfer_ok = current_user.make_donation(dl_artw, params[:amount].to_i)

        download_res dl_artw.name, img_url, transfer_ok

      elsif params[:option] == 'paid'
        img_url = dl_artw.image.service_url # TODO : change to high quality img

        transfer_ok = current_user.make_purchase(dl_artw)

        download_res dl_artw.name, img_url, transfer_ok
      end
    else
      redirect_to dl_artw.image.service_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artwork_params
      params.require(:artwork).permit(:name, :description, :image, :value, :category_id, :is_public)
    end

    def download_res(artw_name, img_url, transfer_ok)
      if transfer_ok
        render json: { img_url: img_url, artw_name: artw_name }
      else
        render json: {
          error: 'Cannot make point transfer and download the artwork. ' +
                 'Make sure you have enough points.'
        }
      end
    end
end
