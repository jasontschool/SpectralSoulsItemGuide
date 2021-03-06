
require_relative "ConstantsFactory"
require_relative "SSItemSearchTest.rb"

# NOTE: All files being loaded must be present in a folder called "sources"
#   that is located in this file's directory.
def loadSSFiles
    filepaths = {
        :equip=>'spectral_souls_psp_equip.txt',
        :test => 'testItem.txt',
        :creation => 'creation guide.txt',
    }
    if defined? Rails
      home = Rails.root.join('db/sources/')
    else
      home = File.dirname(__FILE__) + '/sources/'
    end
    files_hash = filepaths.each_with_object({}) do |(k, v), h|
        begin 
            path = home + v
            h[k] = File.read path
            #puts "#{k} loaded successfully: #{h[k]}" if k==:test
            #puts home
        rescue Errno::ENOENT
            puts home
            raise "Warning: File '#{k}' at '#{path}' not found"
        end
    end
    #extracting only portions that are required:
    creation = files_hash.delete(:creation)
    creation_extract creation, files_hash #see ConstantsFactory
    
    return files_hash
end

#Adjust for typos/mistakes.
def correct_item_hash(item_hash, source)
    #swap buy/sell prices
    case source
    when :equip
      if item_hash["sell"]
        temp = item_hash["buy"]
        item_hash["buy"] = item_hash["sell"]
        item_hash["sell"] = temp
      else 
        item_hash.delete "sell"
      end
      item_hash.delete "invent1" #now covered in invent_equip
      item_hash.delete "invent2"
      return item_hash
    when :synth, :mast
      item_hash["components"] = synth_breakdown item_hash["components"]
      return item_hash
    when :invent_equip
      item_hash.each {|k, v| item_hash[k] = v.strip unless v.nil?}
      item_hash["invents"] = [item_hash["parent1"]]
      item_hash["invents"] << item_hash["parent2"] unless item_hash["parent2"].nil?
      item_hash.delete("parent1")
      item_hash.delete("parent2")
      return item_hash
      
    end
end

#Adjust for db setup - not used?
def prepare_item_hash(item_hash)
   item_hash["unique_user"] = !!item_hash["unique_user"]  #boolean
   code = item_hash["range_unique_code"]
   item_hash["range_unique_code"] = code ? code.length : 0
end

def hashify_match(match, source)
	return correct_item_hash Hash[match.names.zip(match.captures)], source
end

def get_hash_matches(files, regex, source)
    matches = files[source].to_enum(:scan, regex).map { Regexp.last_match }
    results = []
    matches.each do |match|
        results << (hashify_match match, source)
    end
    return results
end

def execute_with_files(files_hash)
    all_results = {}
    files_hash.each do |k, v|
        if (constants_hash = get_constants k)
            file_results = get_hash_matches files_hash, constants_hash[:regex], k
            all_results[k] = file_results
        end
    end
    return all_results #hash of file results.
end

def prepare_seed
    files = loadSSFiles()
    results = execute_with_files files
    #puts results[:test].last
    #raise "Errors when loading equipment from files" unless check_accurate results, files
    #Note: no tests written for other files, too difficult to maintain =( This is a one-man winter break project...
    #*BAD PRACTICE. then again no tests elsewhere too ><.
    return results
end

def local_test(tests)
  files = loadSSFiles()
  file_results = {}
  tests.each do |test|
    if (constants_hash = get_constants test)
    #print constants_hash
      file_results[test] = get_hash_matches files, constants_hash[:regex], test
      #puts file_results
      puts "#{file_results[test].count} matches found in #{test}"
      puts file_results[test][1..10]
    end
  end
  
  #puts file_results[:invent_equip][30..35]
  #puts file_results[:synth][0..10]
  #select{|x| x["components"].any?{|x| x=~ /Strata/}}
  #puts file_results[:synth].select{|x| x["name"] =~ /(Power)|(Body)/}
end


#local_test([:equip])
