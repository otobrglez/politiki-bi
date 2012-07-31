# By Oto Brglez - <oto.brglez@opalab.com>

require "bundler/setup"
require "lib/manager"
require 'amqp'
require 'logger'

puts "Starting. "

Log=Logger.new($stdout)
m = Manager.new

EM.run do
	Log.debug("up.")

	connection = AMQP.connect(m.config["amqp_url"])
	channel  = AMQP::Channel.new(connection)

	queue = channel.queue("measurements", :auto_delete => true)
	queue.subscribe do |m_id|
		Log.info("Processing: #{m_id}")
		begin
			me = FMeasurement.new_from_denormalized(m.measurement(m_id))
		rescue Exception => e
			Log.warn("Bot error : #{e.message}")
		end
		Log.debug("done.")
	end

	Signal.trap("INT")  { EventMachine.stop }
	Signal.trap("TERM") { EventMachine.stop }	 
end