require 'timecop'

#
# TemporalHelpers module group all the needed methods to use Timecop with
# Cucumber
#
# @author [zedtux]
#
module Temporal
  # Travels to +time+ and lets the clock keep running.
  #
  # If a block is given, executes the block at that
  # time then returns to the present.
  def travel_to(time, &block)
    Timecop.travel parse_time(time), &block
  end

  # Travels to and freezes the clock at +time+.
  #
  # If a block is given, executes the block at that
  # time then returns to the present.
  def freeze_time_at(time, &block)
    Timecop.freeze parse_time(time), &block
  end

  private

  def parse_time(time)
    Time.parse(time)
  end
end