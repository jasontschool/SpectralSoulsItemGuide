require_relative "ConstantsFactory"
require_relative "SSItemSearchTest.rb"

def loadSSFiles
    filepaths = {
        :equip=>'spectral_souls_psp_equip.txt',
        :test => 'testItem.txt',
    }
    missingFiles = 0
    files_hash = filepaths.each_with_object({}) do |(k, v), h|
        begin 
            h[k] = File.read File.dirname($0) + '/' + v
            #puts "#{k} loaded successfully"
        rescue Errno::ENOENT
            puts "Warning: File '#{k}' at '#{filepaths[k]}' not found"
            missingFiles+= 1
        end
    end
    puts "Warning: #{missingFiles} file#{"s" if missingFiles > 1} not found." unless missingFiles == 0
    return files_hash
end

#Adjust for typos/mistakes.
def correct_item_hash(item_hash)
    #swap buy/sell prices
    temp = item_hash["buy"]
    item_hash["buy"] = item_hash["sell"]
    item_hash["sell"] = temp
    return item_hash
end
def hashify_match(match)
	return correct_item_hash Hash[match.names.zip(match.captures)]
end

def get_hash_matches(contents, regex)
    matches = contents.to_enum(:scan, regex).map { Regexp.last_match }
    results = []
    matches.each do |match|
        results << (hashify_match match)
    end
    return results
end

def execute_with_files(files_hash)
    all_results = {}
    files_hash.each do |k, v|
        if (constants_hash = get_constants k)
            file_results = get_hash_matches v, constants_hash[:regex]
            all_results[k] = file_results
        end
    end
    return all_results #hash of file results.
end







files = loadSSFiles()
results = execute_with_files files
if check_accurate results, files
    puts results[:test].last if ARGV[0] == "last"
else
    raise "Errors when loading equipment from files"
end

 
