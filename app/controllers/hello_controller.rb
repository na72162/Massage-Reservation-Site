class HelloController < ApplicationController
  def world
    render json: { message: 'Hello, World!' }
  end
end
