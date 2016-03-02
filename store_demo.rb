require_relative './store_demo/checkout.rb'
require_relative './store_demo/product.rb'
require_relative './store_demo/pricing_rules.rb'

module StoreDemo
end

rule1 = StoreDemo::PricingRule.new('reduce_apple',proc{|x|x>2},proc{|x,c|(x.price-50)*c},'AP1')

co = StoreDemo::Checkout.new(['reduce_apple'])
co.add_pricing_rule('reduce_steak',proc{|x|x>1},proc{|x,c|(x.price-80)*c},'ST1')

co2 = StoreDemo::Checkout.new(['reduce_apple'])
co2.add_pricing_rule('reduce_steak',proc{|x|x>1},proc{|x,c|(x.price-80)*c},'ST1')

StoreDemo::Product.new('banana',100,'BN1')
StoreDemo::Product.new('apples',100,'AP1')
StoreDemo::Product.new('yogurt',200,'YG1')
StoreDemo::Product.new('bread',50,'BR1')
StoreDemo::Product.new('steak',400,'ST1')

co.scan('BN1')
co.scan('BN1')
co.scan('AP1')
co.scan('AP1')
co.scan('AP1')
co.scan('YG1')
co.scan('YG1')
co.scan('BR1')
co.scan('BR1')
co.scan('ST1')
co.scan('ST1')

puts co.total

co2.scan('BN1')
co2.scan('BN1')
co2.scan('AP1')
co2.scan('AP1')
co2.scan('AP1')
co2.scan('YG1')
co2.scan('YG1')
co2.scan('BR1')
co2.scan('BR1')
co2.scan('ST1')
co2.scan('ST1')

puts co2.total