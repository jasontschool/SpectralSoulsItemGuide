
require_relative "ConstantsFactory"
require_relative "SSItemSearchTest.rb"

# NOTE: All files being loaded must be present in a folder called "sources"
#   that is located in this file's directory.
def loadSSFiles
    filepaths = {
        :equip=>'spectral_souls_psp_equip.txt',
        :test => 'testItem.txt',
		#:creation=>'creation_guide.txt',
    }
    home = Rails.root.join('db/sources/')
    puts home
    files_hash = filepaths.each_with_object({}) do |(k, v), h|
        begin 
            path = home + v
            h[k] = File.read path
            #puts "#{k} loaded successfully: #{h[k]}" if k==:test
            #puts home
        rescue Errno::ENOENT
            puts Dir.pwd
            raise "Warning: File '#{k}' at '#{path}' not found"
        end
    end
    return files_hash
end

#Adjust for typos/mistakes.
def correct_item_hash(item_hash)
    #swap buy/sell prices
    if item_hash["sell"]
      temp = item_hash["buy"]
      item_hash["buy"] = item_hash["sell"]
      item_hash["sell"] = temp
    else 
      item_hash.delete "sell"
    end
    return item_hash
end

#Adjust for db setup - not used?
def prepare_item_hash(item_hash)
   item_hash["unique_user"] = !!item_hash["unique_user"]  #boolean
   code = item_hash["range_unique_code"]
   item_hash["range_unique_code"] = code ? code.length : 0
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

def prepare_seed
    files = loadSSFiles()
    results = execute_with_files files
    puts results[:test].last
    raise "Errors when loading equipment from files" unless check_accurate results, files
    return results
end

files = loadSSFiles()
if (constants_hash = get_constants :test)
  print constants_hash
  file_results = get_hash_matches files[:test], constants_hash[:regex]
  print file_results
end