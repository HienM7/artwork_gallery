class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]

  # GET /artworks
  # GET /artworks.json
  def index
    @artworks = Artwork.search(params[:keyword])
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
    # TODO: @similar = Artwork.search_same_cat.most_hearted
    # TODO: @same_author = Artwork.search_same_author.most_hearted
    # except current artwork

    @similar = Artwork.order('random()').limit(5)
    @same_author = Artwork.order(name: :desc).limit(5)
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
    @artwork = Artwork.new(artwork_params)

    respond_to do |format|
      if @artwork.save
        format.html { redirect_to @artwork, notice: 'Artwork was successfully created.' }
        format.json { render :show, status: :created, location: @artwork }
      else
        format.html { render :new }
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
      transfer_ok = true  # TODO, stub here
      dl_artw = Artwork.find(params[:id])
      
      if params[:option] == 'free'
        # img_url = dl_artw.img_link
        img_url = 'https://res.cloudinary.com/dg3yegu7g/image/upload/v1588155445/met0x6w42pzg4kjs5ooj.jpg'
        
        if params[:amount].to_i > 0
          # transfer_ok = make_transfer(current_user, artw_owner)
          
          if transfer_ok
            render json: { img_url: img_url, artw_name: dl_artw.name }
          else
            render json: {
              error: 'Cannot transfer points and download the artwork. ' +
                     'Make sure you have enough points.'
            }
          end

        else
          render json: { img_url: img_url, artw_name: dl_artw.name }
        end
      
      elsif params[:option] == 'paid'
        img_url = 'https://res.cloudinary.com/dg3yegu7g/image/upload/v1588155445/met0x6w42pzg4kjs5ooj.jpg'
        # img_url = dl_artw.download_link
        # transfer_ok = make_transfer(current_user, artw_owner)

        if transfer_ok
          render json: { img_url: img_url, artw_name: dl_artw.name }
        else
          render json: {
            error: 'Cannot transfer points and download the artwork. ' +
                   'Make sure you have enough points.'
          }
        end
      end

    else
      redirect_to dl_artw.img_link
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artwork_params
      params
      .require(:artwork)
      .permit(:name, :img_link, :value, :is_public, :keyword)
    end

    # MOVE TO USER
    # def able_to_pay(amount)
    #   return current_user.point > amount
    # end

    # def make_transfer(usr1, usr2)
    # end
end
