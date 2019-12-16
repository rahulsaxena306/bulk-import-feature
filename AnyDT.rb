
require 'date'


# Converts the format provided by the user eg. [DD/MM/YYYY]
# and converts into the parsing format eg. %d/%m/%Y
def formatConvertor(inputFormat)

  inputFormat.sub! 'DD', '%d'
  inputFormat.sub! 'YYYY', '%Y'
  inputFormat.sub! 'YY', '%Y'
  inputFormat.sub! 'MM', '%m'
  inputFormat.sub! 'hh', '%H'
  inputFormat.sub! 'mm', '%M'
  inputFormat.sub! 'ss', '%S'
  inputFormat.sub! 'HH', '%I' # HH - for hour of the clock (12 hour)
  inputFormat.sub! 'A/P', '%p'
  inputFormat.sub! 'MON', '%b' # Jan/Feb etc
  #inputFormat.sub! 'TZ', '%z' # TimeZone


end


def dateTimeParser(dateTimeString, inputFormat)
  if dealer(inputFormat) == 1
    puts "True"
    ft = formatConvertor(inputFormat)
    begin
      dt = DateTime.strptime(dateTimeString, ft)
      dt = dt.to_s
      puts dt.slice(0..(dt.index("T") - 1))
    rescue
      puts "Invalid String or String does not match the specified format"
    end
    return
  elsif dealer(inputFormat) == -1
    # Dealing with UNIX date time format
    begin
      dt = DateTime.strptime(dateTimeString, '%s')
      dt = dt.to_s
      print "#{dt}"
    rescue
      puts "Invalid String or String does not match the specified format"
    end
    return
  else
    usualParser(dateTimeString, inputFormat)
  end
end

# To be called whenever the dateTimeString contains both date and time stamps
def usualParser(dateTimeString, inputFormat)
  ft = formatConvertor(inputFormat)
  puts ft
  begin
    dt = DateTime.strptime(dateTimeString, ft)
    print "#{dt}"
  rescue
    puts "Invalid String or String does not match the specified format"
  end
end


# Dealing with the case when time is not specified
def dealer(inputFormat)
  if !inputFormat.include? "hh" and !inputFormat.include? "HH"
    if !inputFormat.include? "YYYY" and !inputFormat.include? "YY"
      return -1
    end
    return 1
  end
end


# Invoking the function dateTimeParser on the sample
# string and some random output format
dateTimeParser("2019 Sep 03","YYYY MON DD")

# Additonal Comments
# puts dealer("YYYY-MON-DD hh:mm:ss")
# Creating a sample input DateTime String
# strDT = DateTime.now().strftime('%Y-%m-%d')

# print "#{strDT} \n"
# Time.strptime("1318996912345",'%Q').to_f and you will see the milliseconds preserved
# while DateTime.strptime("1318996912345",'%Q').to_f does not preserve it
