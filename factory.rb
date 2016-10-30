class Factory
    def self.new(*args, &block)
        Class.new do
            attr_accessor(*args)
            define_method :initialize do |*arg|
                args.each_with_index do |v, i| 
                    instance_variable_set "@#{v}", arg[i]
                end
            end
            
            def [](argument)
                argument = (argument.is_a? Numeric) ? instance_variables[argument] : "@#{argument}"
                instance_variable_get argument
            end
            
             class_eval(&block) if block_given?
        end
    end
end

Student = Factory.new(:sex, :name, :age)
kir = Student.new('man', 'Kirill', 24)

puts kir[:sex]
puts kir[:age]
puts kir[:name]