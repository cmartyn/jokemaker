class JokesController < ApplicationController
  def new
    @joke = Joke.new
  end

  def show
    @joke = Joke.find_by(id: params[:id], secret: params[:secret])
  end

  def create
    @joke = Joke.new(joke_params)
    if @joke.save
      JokeCreationJob.perform_later(@joke)
      redirect_to joke_path(@joke, secret: @joke.secret)
    else
      render :new
    end
  end

  private

  def joke_params
    params.require(:joke).permit(:prompt)
  end
end
