class BroadcastNoteJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast 'notes', data
  end
end