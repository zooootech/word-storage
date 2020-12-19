class WordsController < ApplicationController
  def index
    @words = Word.all.order(:english)
  end
end
