# Can be used to debug full stack error
# Which does not give a stacktrace by itself

# $enable_tracing = false
# $trace_out = open('trace.txt', 'w')
# 
# set_trace_func proc { |event, file, line, id, binding, classname|
#   if $enable_tracing && event == 'call'
#     $trace_out.puts "#{file}:#{line} #{classname}##{id}"
#   end
# }
# 
# $enable_tracing = true
