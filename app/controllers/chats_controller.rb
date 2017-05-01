require 'slack_channel'

class ChatsController < ApplicationController
  def index
    # list all the slack channels
    @channels = SlackChannel.all
  end

  def new_message
    # Form to type a new message to a given slack channel
    @channel = SlackChannel.new(params[:channel])
  end

  def send_message
    # Handle the result of the above form
    channel = SlackChannel.new(params[:channel])
    channel.send(params[:message])
    redirect_to chats_path
  end
end
