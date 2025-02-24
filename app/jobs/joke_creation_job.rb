class JokeCreationJob < ApplicationJob
  queue_as :default

  def perform(joke)
    JokeCreation.new(joke).call
    JokeCartoonCreation.new(joke).call
  end
end
