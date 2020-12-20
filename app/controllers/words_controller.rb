class WordsController < ApplicationController
  def index
    @words = Word.all.order(:english)
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.valid?
      @word.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit(:english, :japanese, :remarks).merge(user_id: current_user.id)
  end


end
