class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    @sort = params[:sort]
    @direction = params[:direction]
  
    subquery = Movie.select('MIN(id) as id').group(:title, :release_date)
    @movies = Movie.where(id: subquery)
  
    if @sort.present? && @direction.present?
      case @sort
      when 'release_date'
        @movies = @movies.order(Arel.sql("release_date #{@direction}"))
      else
        @movies = @movies.order(Arel.sql("LOWER(#{ActiveRecord::Base.connection.quote_column_name(@sort)}) #{@direction}"))
      end
    end
  end
  
  # GET /movies/1 or /movies/1.json
  def show
    @sort = params[:sort]
    @direction = params[:direction]
  end  

  # GET /movies/new
  def new
    @movie = Movie.new
    @sort = params[:sort]
    @direction = params[:direction]
  end

  # GET /movies/1/edit
  def edit
    @sort = params[:sort]
    @direction = params[:direction]
  end

  # POST /movies or /movies.json
  def create
    @sort = params[:sort]
    @direction = params[:direction]
    @movie = Movie.new(movie_params)
    respond_to do |format|
      if @movie.save
        format.html { redirect_to movies_path(sort: params[:sort], direction: params[:direction]), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    @sort = params[:sort]
    @direction = params[:direction]
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_path(@movie, sort: params[:sort], direction: params[:direction]), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!
    respond_to do |format|
      format.html { redirect_to movies_path(sort: params[:sort], direction: params[:direction]), status: :see_other, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.expect(movie: [ :title, :rating, :description, :release_date ])
    end
end