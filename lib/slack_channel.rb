class SlackChannel

  class SlackChannel < StandardError
  end

  # WE DO NOT WANT TO ADD SLACK TOKEN TREAT LIKE OAUTH ID
  BASE_URL = "https://slack.com/api/"

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def send(message)

    query_params = {
      "token" => ENV["SLACK_API_TOKEN"],
      "channel" => @name,
      "text" => message,
      "username" => "Heart Attack Jack",
      "icon_emoji" => ":fries:",
      "as_user" => "false"
    }

    url = "#{BASE_URL}chat.postMessage"
    response = HTTParty.post(url, query: query_params)

    if response["ok"]
      puts "Everything went swell"
    else
      raise SlackException.new(response["error"])
    end
  end

  def self.all
    url = "#{BASE_URL}channels.list?token=#{ENV["SLACK_API_TOKEN"]}"
    response = HTTParty.get(url).parsed_response

    if response["ok"]
      channel_list = response["channels"].map do |channel_data|
        self.new(channel_data["name"])
      end

      return channel_list
    else
      raise SlackException.new(response["error"])
    end
  end
end
