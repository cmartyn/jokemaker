class JokeCartoonCreation
  include Raix::ChatCompletion

  attr_accessor :joke

  def initialize(joke)
    self.joke = joke
  end

  def call
    require "open-uri"
    prompt = get_prompt
    image_url = get_image_url(prompt)
    tempfile = Down.download(image_url)
    joke.cartoon.attach(io: tempfile, filename: "cartoon.png")
    joke.save!
  end

  def get_image_url(prompt)
    response = OpenAI::Client.new.images.generate(
      parameters: {
        prompt: prompt,
        model: "dall-e-3",
        size: "1024x1024",
        quality: "standard"
      }
    )
    response.dig("data", 0, "url")
  end

  def get_prompt
    transcript << { system: "You are helping to generate a cartoon to go along with a joke, and your job is writing a good prompt for DALL-E to generate it. Respond with only the text of the prompt for DALL-E." }
    transcript << { user: "I asked for a joke about #{joke.prompt}, and here is the joke:\n\n#{joke.content}" }
    chat_completion
  end
end
