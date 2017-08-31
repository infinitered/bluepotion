class PMHashBundle
  KEYS_KEY = "pm_hash_bundle_hash_keys"
  VALUE_TYPES_KEY = "pm_hash_bundle_value_types"

  def initialize(bundle, hash)
    @bundle = bundle
    @hash = hash
  end

  def to_bundle
    @bundle
  end

  def to_h
    @hash
  end

  class << self

    def from_bundle(bundle)
      #hash_keys = fragment_arguments.getStringArrayList("hash_keys")
      h = {}

      keys = bundle.getStringArrayList(PMHashBundle::KEYS_KEY)
      value_types = bundle.getStringArrayList(PMHashBundle::VALUE_TYPES_KEY)

      keys.each_with_index do |key, i|
        value_type = value_types[i]

        value = case value_type
        when "com.rubymotion.String", "String"
          bundle.getString(key)
        when "com.rubymotion.Symbol", "Symbol"
          bundle.getString(key).to_sym
        when "java.lang.Integer", "Integer"
          bundle.getInt(key)
        when "java.lang.Double", "Double"
          bundle.getFloat(key)
        when "java.util.ArrayList", "ArrayList"
          bundle.getStringArrayList(key)
          # TODO, do more types
        else
          raise "[BluePotion ERROR] In PMHashBundle#from_hash: invalid type for: #{key}"
        end

        h[key.to_sym] = value
      end

      PMHashBundle.new(bundle, h)
    end

    def from_hash(h)
      bundle = Potion::Bundle.new
      keys = h.keys.map(&:to_s)
      values = h.values
      value_types = h.values.map do |value|
        value.class.name
      end
      bundle.putStringArrayList(PMHashBundle::KEYS_KEY, keys)
      bundle.putStringArrayList(PMHashBundle::VALUE_TYPES_KEY, value_types)

      keys.each_with_index do |key, i|
        value_type = value_types[i]
        value = values[i]

        case value_type
        when "com.rubymotion.String", "String"
          bundle.putString(key, value)
        when "com.rubymotion.Symbol", "Symbol"
          bundle.putString(key, value.to_s)
        when "java.lang.Integer", "Integer"
          bundle.putInt(key, value)
        when "java.lang.Double", "Double"
          bundle.putFloat(key, value)
        when "java.util.ArrayList", "ArrayList"
          value = value.map{|o| o.to_s}
          bundle.putStringArrayList(key, value)
        # TODO, do more types
        else
          raise "[BluePotion ERROR] In PMHashBundle#from_hash: invalid type for: #{key}"
        end
      end

      PMHashBundle.new(bundle, h)
    end
  end
end
