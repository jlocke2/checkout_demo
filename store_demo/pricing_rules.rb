module StoreDemo
  class PricingRule
    @@rules ||= {}

    def initialize(name, conditional, affect, product_code)
      @@rules[name] = {conditional: conditional, affect: affect, product_code: product_code}
    end

    def self.get_totals(co_rules, co_items)
      price_list = []
      co_rules.each do |rule|
        price_list << apply_rule(@@rules[rule][:conditional], @@rules[rule][:affect], @@rules[rule][:product_code], co_items)
        product = StoreDemo::Product.find_by_code(@@rules[rule][:product_code])
        co_items.delete(product)
      end
      co_items.each do |product, count|
        puts "#{product.name} is #{product.price} with #{count}"
        price_list << product.price * count
      end
      puts price_list
      price_list
    end

    def self.validate(pricing_rules)
      pricing_rules.each do |rule|
        raise 'Rule Doesn\'t Exist' unless @@rules.keys.include?(rule)
      end
    end

    private

    def self.apply_rule(conditional, affect, code, co_items)
      product = StoreDemo::Product.find_by_code(code)
      adjust_price(affect, product, co_items[product]) if check_conditional(conditional, co_items[product])
    end

    def self.adjust_price(affect, product, count)
      affect.call(product, count).to_i
    end

    def self.check_conditional(conditional, count)
      conditional.call(count)
    end

  end
end