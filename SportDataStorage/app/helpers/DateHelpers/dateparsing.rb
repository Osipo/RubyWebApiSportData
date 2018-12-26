#coding:utf-8
require 'date'
module DateHelpers

class DateNotifyer
	def initialize()
		@changed = false;
	end

	def getNotification()
		return @changed;
	end

	def checkDate(path)
		if(!path.is_a?(String))
			raise ArgumentError::new("Type must be String. Actual: #{path.class}");
		end
		begin
			File.open(path,'a+') do |afile|
				if afile
					line = afile.gets;
					puts line;
					if(!line)
						cd = DateTime.now.inspect.slice(12,10).to_s;
						afile.syswrite(cd);
						puts "Date was written #{cd}  ::  #{DateTime.now.inspect}";
						@changed = true;
						#method api call.
					else
						dn = DateTime.now.inspect.slice(12,10).to_s;
						d1 = DateTime.iso8601(dn); # or dn
						d2 = DateTime.iso8601(line);
						puts "Now: #{d1}"
						puts "Current: #{d2}"
						puts "Difference in days = #{(d1 - d2).to_i}"
						if((d1 - d2).to_i > 0)
							afile.truncate(0);
							afile.write(dn);
							@changed = true;
							#method api call.
						else
							@changed = false;
						end
					end
				else
					puts "Unable to open File Input.txt";
				end
			end
		rescue EOFError
			File.open(path,'w+') do |afile|
				if afile
					afile.syswrite(DateTime.now.inspect.slice(12,10).to_s)
					puts "Date was written"
				else
					puts "UNable to open FIle "
				end
			end
		end
	end
end
#Testing.
# ob = DateNotifyer.new
# ob.checkDate("input");
# puts "Changed ? : #{ob.getNotification}";

end