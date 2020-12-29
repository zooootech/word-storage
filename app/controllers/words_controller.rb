class WordsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_word, only: [:show, :destroy, :edit, :update]

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

  def show
  end

  def destroy
    redirect_to word_path(@word) if current_user != @word.user
    @word.destroy
    redirect_to root_path
  end

  def edit
    redirect_to word_path(@word) if current_user != @word.user
  end

  def update
    if @word.update(word_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def word_params
    params.require(:word).permit(:english, :japanese, :remarks).merge(user_id: current_user.id)
  end

  def set_word
    @word = Word.find(params[:id])
  end

end
