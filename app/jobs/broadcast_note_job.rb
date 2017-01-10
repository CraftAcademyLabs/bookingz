class BroadcastNoteJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast 'note', data
  end
end