class Config

  # Config class is storage of :key => "value"
  # You can get and set values by invoking config.key value
  # All values will be transformed to strings through to_s
  
  include Sugar
  singleton_INSTANCE

  def initialize
    @config = {} of Symbol => String
  end

  macro method_missing(name, args, block)
    {% if args[0] == nil %}
      begin
        return @config[:{{name}}]
      rescue e
        raise "[Error] No config key with name :{{name.id}}"
        return
      end
    {% else %}
        @config[:{{name.id}}] = {{args[0]}}.to_s
    {% end %}
  end

  def configure(&block)
    with self yield self 
  end
end