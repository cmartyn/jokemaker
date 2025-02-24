class JokeCreation
  include Raix::ChatCompletion

  attr_accessor :joke

  def initialize(joke)
    self.joke = joke
    # self.model = "anthropic/claude-3.5-sonnet"
    self.model = "openai/o3-mini"
    # self.model = "meta-llama/llama-3.3-70b-instruct"
  end

  def call
    transcript << { system: "You write jokes for a premier late-night talk show, where there is a premium on having cutting-edge jokes that have not been heard before. The user will provide a topic and you will generate a joke. Do not include any other text than the joke." }
    transcript << { user: joke.prompt }
    result = chat_completion
    joke.content = result
    joke.save!
  end
end
