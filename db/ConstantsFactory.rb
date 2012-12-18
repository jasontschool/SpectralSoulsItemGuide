
def get_constants(filename)
    begin
        return eval "#{filename}"
    rescue NameError
        print "Error - constants not found!: '#{filename}'\n"
        return nil
    end
end

def test #test method
    return synth
end
def equip
    return {
    :regex => #'?' at begining of optional lines for the newline char.
    /\s*\d+\. ?\d+\. (?<name>[\w +'-]+)\n+
Type            : (?<item_type>[\w ]+)( \((?<unique_user>\*+)\))?
?(Range           : (?<range>[\d]+)( \((?<range_unique_code>\*+)\))?)?
?(Height          : (?<height>[\d]+))?
Element         : (?<element>[\w\(\)]+)
?(Absorbs Element : (?<absorb>[\w\(\)]+))?
Register\?       : (?<register>[\w]+)
Selling Price   : (?<sell>([\d]+)|(n\/a))( G)?
Buying Price    : (?<buy>([\d]+)|(n\/a))( G)?
Invents into    : (?<invent1>[\w \(\)+'-]+)
                : (?<invent2>[\w \(\)+'-]+)
?(Weapon slot 1   : (?<weapon1>[\w\(\) ]+)(, level (?<weapon1_level>\d))?
Weapon slot 2   : (?<weapon2>[\w\(\) ]+)(, level (?<weapon2_level>\d))?
Weapon slot 3   : (?<weapon3>[\w\(\) ]+)(, level (?<weapon3_level>\d))?
Weapon slot 4   : (?<weapon4>[\w\(\) ]+)(, level (?<weapon4_level>\d))?)?
?(Autoskill       : (?<autoskill>[\w\(\) %+]+)
Autoskill Slots : (?<autoskill_slot_count>\d))?

\+------\+------\+------\+------\+------\+------\+
\| lvl  \|    1 \|    2 \|    3 \|    4 \|    5 \|
\+------\+------\+------\+------\+------\+------\+
\| ATK  \|\s+(?<atk1>\d+)\s+\|\s+(?<atk2>\d+)\s+\|\s+(?<atk3>\d+)\s+\|\s+(?<atk4>\d+)\s+\|\s+(?<atk5>\d+)\s+\|
\| DEF  \|\s+(?<def1>\d+)\s+\|\s+(?<def2>\d+)\s+\|\s+(?<def3>\d+)\s+\|\s+(?<def4>\d+)\s+\|\s+(?<def5>\d+)\s+\|
\| HIT  \|\s+(?<hit1>\d+)\s+\|\s+(?<hit2>\d+)\s+\|\s+(?<hit3>\d+)\s+\|\s+(?<hit4>\d+)\s+\|\s+(?<hit5>\d+)\s+\|
\| AVD  \|\s+(?<avd1>\d+)\s+\|\s+(?<avd2>\d+)\s+\|\s+(?<avd3>\d+)\s+\|\s+(?<avd4>\d+)\s+\|\s+(?<avd5>\d+)\s+\|
\| MAG  \|\s+(?<mag1>\d+)\s+\|\s+(?<mag2>\d+)\s+\|\s+(?<mag3>\d+)\s+\|\s+(?<mag4>\d+)\s+\|\s+(?<mag5>\d+)\s+\|
\+------\+------\+------\+------\+------\+------\+
\| STR  \|\s+(?<str1>\d+)\s+\|\s+(?<str2>\d+)\s+\|\s+(?<str3>\d+)\s+\|\s+(?<str4>\d+)\s+\|\s+(?<str5>\d+)\s+\|
\| VIT  \|\s+(?<vit1>\d+)\s+\|\s+(?<vit2>\d+)\s+\|\s+(?<vit3>\d+)\s+\|\s+(?<vit4>\d+)\s+\|\s+(?<vit5>\d+)\s+\|
\| AGL  \|\s+(?<agl1>\d+)\s+\|\s+(?<agl2>\d+)\s+\|\s+(?<agl3>\d+)\s+\|\s+(?<agl4>\d+)\s+\|\s+(?<agl5>\d+)\s+\|
\| INT  \|\s+(?<int1>\d+)\s+\|\s+(?<int2>\d+)\s+\|\s+(?<int3>\d+)\s+\|\s+(?<int4>\d+)\s+\|\s+(?<int5>\d+)\s+\|
\| LUK  \|\s+(?<luk1>\d+)\s+\|\s+(?<luk2>\d+)\s+\|\s+(?<luk3>\d+)\s+\|\s+(?<luk4>\d+)\s+\|\s+(?<luk5>\d+)\s+\|
\+------\+------\+------\+------\+------\+------\+
\|\s+(Cost|AP)\s+\|    - \|\s+(?<cost2>\d+)\s+\|\s+(?<cost3>\d+)\s+\|\s+(?<cost4>\d+)\s+\|\s+(?<cost5>\d+)\s+\|
\|\s+(Cost|AP)\s+\|\s+(?<ap1>\d+)\s+\|\s+(?<ap2>\d+)\s+\|\s+(?<ap3>\d+)\s+\|\s+(?<ap4>\d+)\s+\|\s+(?<ap5>\d+)\s+\|
\+------\+------\+------\+------\+------\+------\+/

}

end

def creation_extract(file, store)
  split_creation = /A\. SYNTHESIS(?<synth>[\s\S]+)B\. MASTERIES(?<mast>[\s\S]+)C\. INVENT SKILL(?<invent_skills>[\s\S]+)D\. INVENT WEAPON\/ARMOR\/RING(?<invent_equip>[\s\S]+)----------/
  matches = file.match split_creation
  matches.names.each {|name| store[name.to_sym] = matches[name]}
  #puts matches[:mast]
end

def synth
    return {
    :regex => 
    /\d+\. (?<name>[a-zA-Z+'\- \(\)\?]+)\.* = (?<components>[a-zA-Z '\.+\-\n]+)/
  }
end

def synth_breakdown(components_arr)
  return components_arr.scan(/( \+ )?(?<capture>[a-zA-Z'\- \(\)\?]+\+?)\./).map{|x| x[0].strip}
end
#same as synth
def mast
  return synth
end

def invent_skills
  return {
  :regex => //
  }
end

def invent_equip
  return {
  :regex => /(?<base>[a-zA-Z+'\- \(\)\?]+)\s+> (?<parent1>[a-zA-Z+'\- \(\)\?]+)\s+(; (?<parent2>[a-zA-Z+'\- \(\)\?]+)\s+)?/
  }
end