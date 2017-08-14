class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = policy_scope(Bookmark)
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    @related_in_mine = WebpagesIndex.type_hash["webpage"]
      .query(
        bool: {
          must: [
            # {
            #   has_child: {
            #     type: :bookmark,
            #     query: {
            #       term: {
            #         user_id: current_user.id
            #       }
            #     }
            #   }
            # },
            {
              more_like_this: {
                fields: ["body"],
                like: [
                  { _id: @bookmark.webpage.id, _type: :webpage, _index: WebpagesIndex.index_name }
                ],
                min_term_freq: 20,
                max_query_terms: 30
              }
            }
          ]
        }
      ).objects
  end

  # GET /bookmarks/new
  def new
    @bookmark = current_user.bookmarks.new
  end

  # GET /bookmarks/1/edit
  def edit
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    webpage = Webpage.find_or_create_by(raw_uri: params.dig(:bookmark, :webpage, :raw_uri))
    @bookmark = current_user.bookmarks.new bookmark_params.merge(webpage: webpage)

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update bookmark_params
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bookmark
    @bookmark = authorize Bookmark.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bookmark_params
    permitted_attributes(@bookmark || Bookmark)
  end
end
