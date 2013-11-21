class Factory
  #include Enumerable
  
  def [](index)
    if index.is_a? Integer
      instance_variable_get(instance_variables[index])
    else
      instance_variable_get("@"+index.to_s)
    end
  end
  
  def self.new(*atrs, &block)
    unless self.respond_to? :is_true_class
      klass = Class.new(self)
      klass.class_eval(&block) if block_given?
      klass.class_eval do
        attr_accessor *atrs
        
        define_method(:initialize) do |*values|
          atrs.each_with_index do |name,i|
          instance_variable_set("@"+name.to_s, values[i])
          end
        end
        
        private
        
        def self.is_true_class
          true
        end
      end
      
      return klass
    else 
      super
    end
  end
end

s = Struct.new(:name)
a = Factory.new(:name)

class D < Factory.new(:haha)
end
class AA < Factory ; end
t = AA.new(:name)
p t.new("tt").name
x =  a.new("dfdf")
p x['name']
p D.new("DD").haha
xx = a.new("dfdfxx")
p x, xx
#p s.new("dfdf")

#p a.new.ancestors