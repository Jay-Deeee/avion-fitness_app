class PagesController < ApplicationController
  def dashboard
    seed = Date.today.to_s
    @quote = Quote.offset(Random.new(seed.hash).rand(Quote.count)).first
  end
end
