require 'socket'

socket = TCPServer.open('0.0.0.0', 8080)

# ここで色々requireしておく
# CoW

[:INT, :QUIT].each do |signal|
  trap(signal) do
    p signal
    @wpids.each { |wpid| p wpid; Process.kill(:TERM, wpid) }
  end
end
@wpids = []

2.times do
  @wpids << fork do
    loop do
      connection = socket.accept
      connection.puts 'Hello Readers'
      connection.close
    end
  end
end
p @wpids


Process.waitall

