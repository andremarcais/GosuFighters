require 'json'

class Status
  SCHEMA = {
    "ship" => 0,
    "coins" => 0,
    "name" => "anonymous",
    "inventory" => {
      "gun" => [{"amo" => 100, "damage" => 1, "accuracy" => 0,
                  "speed" => 100}]
    },
    "ships" => [{"hp" => 100, "shield" => 100, "gun" => 0, "model" => 0}]
  }

  def deep_copy(o)
    Marshal.load(Marshal.dump(o))
  end

  def initialize(h = nil)
    @data = h
    validate!
  end

  def self.open_from_name(name)
    open_from_file(File.expand_path("~/.gosu_fighters/Player_data/#{name}"))
  end
  
  def self.open_from_file(path)
    Status.new(File.open(path) { |f| JSON.load(f)})
  end

  def save_name(name)
    save(File.expand_path("~/.gosu_fighters/Player_data/#{name}"))
  end

  def save(path)
    File.open(path, "w") { |f| f.puts(@data.to_json)  }
  end

  def [](key); @data[key]; end
  def []=(key, val); @data[key] = val; end

  def validate_array(array, schema)
    array.each_with_index { |v, i|
      if !v.is_a?(schema.class)
        array[i] = deep_copy(schema)
      elsif schema.is_a?(Hash)
        validate_hash(v, schema)
      end
    }
  end

  def validate_hash(hash, schema)
    (hash.keys - schema.keys).each { |k| hash.delete(k) }
    schema.each { |sk, sv|
      dv = hash[sk]
      if dv.nil? || !dv.is_a?(sv.class)
        hash[sk] = deep_copy(sv)
      elsif sv.is_a?(Array)
        validate_array(dv, sv[0])
      end
    }
  end

  def validate!
    if !@data.is_a?(Hash)
      @data = deep_copy(SCHEMA)
    else
      validate_hash(@data, SCHEMA)
      @data["ship"] = 0 if @data["ship"] >= @data["ships"].size
    end
  end
end
