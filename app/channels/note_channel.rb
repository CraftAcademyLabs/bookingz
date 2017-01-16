# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NoteChannel < ApplicationCable::Channel
  def subscribed
    unless self.params[:data][:facility_code].nil?
      code = self.params[:data][:facility_code]
    else
      code = self.connection.connection_identifier
    end
    stream_from "notes_#{code}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
