class BroadcastNoteJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "notes_#{data[:data][:facility_code]}", data
  end
end