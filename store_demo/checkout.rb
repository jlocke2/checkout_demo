module StoreDemo
  class Checkout

    def initialize(pricing_rules=[])
      @pricing_rules = pricing_rules if StoreDemo::PricingRule.validate(pricing_rules)
      @items ||= Hash.new(0)
    end

    #############################
    #
    # Below we create our public interface
    # these will all be accessible to the outside world
    #
    #############################

    def scan(code)
      product = StoreDemo::Product.find_by_code(code)
      @items[product] += 1
    end

    def total
      processed_items = apply_pricing_rules
      to_dollar(sum_totals(processed_items).to_s)
    end

    def add_pricing_rule(name, conditional, affect, product_code)
      StoreDemo::PricingRule.new(name, conditional, affect, product_code)
      @pricing_rules.push(name)
    end

    #############################
    #
    # Below we create private methods and instance variables 
    # accessible only within each instance
    #
    #############################

    private

    def apply_pricing_rules
      StoreDemo::PricingRule.get_totals(@pricing_rules, @items)
    end

    def sum_totals(items)
      items.reduce(&:+)
    end

    def to_dollar(num_str)
      "$#{num_str.slice!(0..-3)}.#{num_str.slice!(-2..-1)}"
    end

  end
end