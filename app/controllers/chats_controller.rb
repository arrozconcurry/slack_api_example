require 'slack_channel'

class ChatsController < ApplicationController
  def index
    # list all the slack channels
    @channels = SlackChannel.all
  end

  def new
    # Form to type a new message to a given slack channel
  end

  def create
    # Handle the result of the above form
  end
end
