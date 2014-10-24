task :default do
  $LOAD_PATH.unshift ".", "./lib", "./spec"
  Dir['**/{spec,test}_helper', '**/*_{test,spec}.rb'].each {|e| require e }
end
