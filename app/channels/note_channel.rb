# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NoteChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'notes'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify
    ActionCable.server.broadcast('notes', message: data['message'])
  end
end