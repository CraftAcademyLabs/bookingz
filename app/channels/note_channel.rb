# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NoteChannel < ApplicationCable::Channel
  def subscribed
    unless self.params[:facility_id].nil?
      id = self.params[:facility_id]
    else
      id = self.connection.connection_identifier
    end
    stream_from "notes_#{id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
