def greeting

	ARGV[1..-1].each do |name|
		puts "#{ARGV[0]} #{name}"
	end
end

greeting