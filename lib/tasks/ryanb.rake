    task :greet do
      puts "Hello World!"
    end

    task :ask => :greet do
      puts "How are you?"
    end