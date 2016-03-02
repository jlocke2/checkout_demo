module StoreDemo
  class Product
    @@products ||= []
    attr_accessor :name
    attr_accessor :price
    attr_accessor :code

    def initialize(name,price,code)
      @name = name
      @price = price
      @code = code
      @@products.push(self)
    end

    def self.find_by_code(code)
      @@products.find{|p|p.code==code}
    end

  end
end