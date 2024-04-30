require 'csv'
require 'erb'
require 'google/apis/civicinfo_v2'

def clean_zipcode(zipcode)
    return (zipcode || "").rjust(5, "0")[0, 5]
end

# Assignment 1
def clean_phone_number(phone_number)
    digits = phone_number.scan(/\d/)
    if digits.length == 10
        return phone_number
    elsif digits.length == 11 && digits[0] == "1"
        return phone_number[phone_number.index("1") + 1, phone_number.length]
    else
        return nil
    end
end

def legislators_by_zipcode(zipcode, cache = Hash.new)
    if cache.has_key?(zipcode)
        return cache[zipcode]
    end

    civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

    begin
        legislators = civic_info.representative_info_by_address(
            address: zipcode, 
            levels: "country", 
            roles: ["legislatorUpperBody", "legislatorLowerBody"]
        ).officials
        cache[zipcode] = legislators
    rescue => exception
        # do nothing
    end
    
    return legislators || []
end

# Assignment 2
def find_peak_reg_hours(reg_hour_hash)
    peak_hours = find_max_value_key(reg_hour_hash)
    return peak_hours.sort.map { |hour| hour >= 12 ? "#{(hour - 12) + (1 - hour/13) * 12} PM" : "#{hour} AM"}

end

# Assignment 3
def find_peak_dows(reg_dow_hash)
    weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    peak_dows = find_max_value_key(reg_dow_hash)
    return peak_dows.map{ |dow| weekdays[dow] }
end

def find_max_value_key(hash)
    max_val = 0
    max_keys = []
    hash.each do |key, val|
        if val > max_val
            max_val = val
            max_keys = [key]
        elsif val == max_val
            max_keys.push(key)
        end
    end
    return max_keys
end

puts 'Event Manager Initialized!'

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
Dir.mkdir("output") unless Dir.exist?("output")

reg_hour_hash = Hash.new(0)
reg_dow_hash = Hash.new(0)

legislator_cache = Hash.new

contents = CSV.open("event_attendees.csv", 
    headers: true, 
    header_converters: :symbol
)
contents.each do |row|
    name = row[:first_name].capitalize
    zipcode = clean_zipcode(row[:zipcode])
    phone_number = clean_phone_number(row[:homephone])
    
    reg_time = Time.strptime(row[:regdate], "%m/%d/%y %H:%M")
    reg_hour_hash[reg_time.hour] += 1
    reg_dow_hash[reg_time.wday] += 1
    
    legislators = legislators_by_zipcode(zipcode, legislator_cache)
    
    id = row[0]
    file_name = "output/thanks_#{id}.html"
    File.open(file_name, "w") do |file|
        form_letter = erb_template.result(binding)
        file.puts form_letter
    end
end

peak_reg_hours = find_peak_reg_hours(reg_hour_hash)
peak_reg_dow = find_peak_dows(reg_dow_hash)

puts "Peak registration weekdays are #{peak_reg_dow.join(" and ")} and peak registration hours are #{peak_reg_hours.join(" and ")}"