def consolidate_cart(cart)
 new_object = {}

 cart.each do |obj|
   obj.each do |fruit, fruit_value|
     fruit_value.each do |price, cost|
      if(!new_object[fruit])
        new_object[fruit] = {}
      end
      if(!new_object[fruit][price])
        new_object[fruit][price] = cost
      end
     end
      if(!new_object[fruit][:"count"])
      new_object[fruit][:"count"] = 1
      else
      new_object[fruit][:"count"] +=1
      end
   end
 end
 new_object
end


def apply_coupons(cart, coupons)

  coupons.each do |coupon|
    name = coupon[:item]

    if cart[name] && cart[name][:count] >= coupon[:num]
      if (cart["#{name} W/COUPON"])
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:"clearance"]
        cart["#{name} W/COUPON"][:count] = 1
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)

 cart.each do |item_name, obj|
   if (obj[:clearance])
       obj[:price] = obj[:price] - (obj[:price] * 20) / 100
     end
 end
 cart
end

def checkout(cart, coupons)
  organize_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(organize_cart, coupons)
  discounted_cart = apply_clearance(coupons_applied)

  total = 0
  discounted_cart.each do |item_key, value_obj|
    total = total + (value_obj[:price] * value_obj[:count])
  end
  if(total > 100)
    total = total - (total  / 10)
    return total
  else
    return total
  end
end
