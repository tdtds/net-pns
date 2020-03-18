require 'net/pns/version'
require 'socket'

module Net
	class PNS
		class LightError < StandardError; end
		class PlayError < StandardError; end

		def initialize(host, port = 10000, type = 'XX')
			@socket = TCPSocket.new(host, port)
			@type = type.unpack('CC')

			if block_given?
				begin
					yield self
				ensure
					close
				end
			end
		end

		#
		# command keys: :red, :yellow, :green, :blue, :white, :buzzer
		# command values (colors): :off, :on, :blink1, :blink2, :keep (default)
		# command values (buzzer): :off, :buzz1, :buzz2, :buzz3, :buzz4, :keep (default)
		#
		KEYS = [:red, :yellow, :green, :blue, :write, :buzzer]
		VALUES = {
			0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 9 => 9,
			off: 0, on: 1, blink1: 2, blink2: 3, keep: 9,
			buzz1: 1, buzz2: 2, buzz3: 3, buzz4: 4,
		}
		def light(command)
			cmd = KEYS.map{|c| [c, VALUES[command[c]] || 9]}.to_h.values
			ret = send('S', cmd, 1).ord
			raise LightError.new("code 0x#{ret.to_s(16).rjust(2, '0')}") unless ret == 0x06
		end

		def stat
			return send('G', [], 6).unpack('C*')
		end

		PATTERN = {0 => 0, 1 => 1, stop: 0, play: 1}
		def play_sound(ch, pattern = :play, repeat = 0)
			ret = send('V', [PATTERN[pattern] || 1, repeat, 0, ch], 1).ord
			raise PlayError.new("code 0x#{ret.to_s(16).rjust(2, '0')}") unless ret == 0x06
		end

		def clear
			send('C', [], 1)
		end

		def close
			@socket.close
			@socket = nil
		end

	private
		def send(symbol, command, receive_size)
			packet = @type + symbol.unpack('C')
			packet << 0
			packet << command.size
			packet += command
			@socket.write packet.pack('CCCCnC*')
			return @socket.read(receive_size)
		end
	end
end
