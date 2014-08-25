class DaemonTest
  def initialize
    @debug = false
    @worker = 10
    @worker_map = {}
    @signal_queue = []
    @master_self_read_pipe, @master_self_write_pipe = IO.pipe
    @worker_read_pipe, @worker_write_pipe = IO.pipe
  end

  def start
    # ここで全てrequire しておく

    # CHLDを受け取ったら再起動させる

    [:TERM].each do |signal|
      Signal.trap(signal) do
        # write a byte to the self-pipe
        self_writer.write_nonblock('.')
        @signal_queue << signal
      end
    end
    trap(:CHLD) { @master_self_write_pipe.puts('x') }

    begin
      (0 ... @worker).each do |nr|
        if pid = fork
          #parent
          @worker_map[pid] = nr
          puts "master: fork #{pid}"
        else
          # child
          # ここにコード
        end
      end
    end while true

    @worker_map.keys.each do |pid|
      puts "master: Kill to #{pid}"
      Process.kill(:TERM, pid)
    end

    # wait finish worker
    puts "master: Waiting worker to close."
    Process.waitall
    puts "master: Close."
  end
end


