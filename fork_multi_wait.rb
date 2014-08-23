# これは複数のプロセスをforkする

3.times do
  fork do
    sleep_time = rand(5)
    sleep rand(sleep_time)
    p sleep_time
  end
end

#Process.wait

#3.times do
#  puts Process.wait
#end

Process.waitall

p 'Parent process died...'



