child_process_num = 3
dead_process_num  = 0

p $$

child_process_num.times do |num|
  fork do
    sleep 5 + num * 10
  end
end

trap(:CHLD) do
  begin
    while pid = Process.wait(-1, Process::WNOHANG)
      p "Accept CHLD"
      p pid
      dead_process_num += 1
    end
  rescue Errno::ECHILD
  end
end


loop do
  print '*'
  exit if child_process_num == dead_process_num
  sleep 1
end

