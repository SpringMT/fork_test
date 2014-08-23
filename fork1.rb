# メインループ
#loop do
  if pid = fork
    # master
    p "master process '#{pid}' : '#{$$}' '#{Process.pid}' '#{Process.ppid}'"
  else
    p "child process  '#{pid}' : '#{$$}' '#{Process.pid}' '#{Process.ppid}'"
  end
#end

