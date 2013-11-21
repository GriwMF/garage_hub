class Module
  def attribute(a, &block)
    if a.is_a? Hash
      key, value = a.to_a.flatten
      a = key
    end
    
    class_eval do
      attr_writer a
      
      define_method a + '?' do
       if __send__(a)
         true
       else
         false
       end
      end
      
      define_method a do
        p instance_variables
        if instance_variables.map(&:to_s).include? "@#{a}"
          instance_variable_get "@#{a}"
        else
           block ? instance_eval(&block) : value
        end
      end
      
   end

  end
end