def make_change(value, coins)
  return [] if coins.empty?
  coin = coins.first

  if value >= coin
    option1 = [coin] + make_change(value - coin, coins)
  else
    option1 =  make_change(value, coins.drop(1))
  end
  option2 = make_change(value, coins.drop(1))

  if option2.empty?
    return option1
  else
    case option1.length <=> option2.length
    when -1
      option1
    when 0
      option1
    when 1
      option2
    end
  end
end
