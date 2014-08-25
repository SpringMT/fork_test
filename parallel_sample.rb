require 'parallel'

Parallel.map([1,2,3]) do |x|
  raise Parallel::Kill if x == 1# -> stop all sub-processes, killing them instantly
  p x
  sleep 10
end

