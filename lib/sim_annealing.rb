require "sim_annealing/version"

module SimAnnealing
  class SimAnnealing
    # distance, between cities
    def euc_2d(c1, c2)
      Math.sqrt((c1[0] - c2[0]) ** 2.0 + (c1[1] - c2[1]) ** 2.0).round
    end

    # cost, of the path
    def cost(sh, cities)
      distance = 0
      sh.each_with_index do |c1, i|
        c2 = (i == sh.size - 1) ? sh[0] : sh[i + 1]
        distance += euc_2d(cities[c1], cities[c2])
      end
      distance
    end

    # shake, cities
    def shake(cities)
      sh = Array.new(cities.size){|i| i}
      sh.each_index do |i|
        r = rand(sh.size - i) + i
        sh[r], sh[i] = sh[i], sh[r]
      end
      sh
    end

    # shake, cities in range
    def two_opt(sh)
      c1, c2 = rand(sh.size), rand(sh.size)
      skip = [c1]
      skip << ((c1 == 0) ? sh.size - 1 : c1 - 1)
      skip << ((c1 == sh.size - 1) ? 0 : c1 + 1)
      c2 = rand(sh.size) while skip.include?(c2)
      c1, c2 = c2, c1 if c2 < c1
      sh[c1...c2] = sh[c1...c2].reverse
      sh
    end

    # get neighbor
    def get_neighbor(current, cities)
      candidate = {}
      candidate[:vector] = Array.new(current[:vector])
      two_opt(candidate[:vector])
      candidate[:cost] = cost(candidate[:vector], cities)
      candidate
    end

    # accept, ?
    def should_accept?(candidate, current, temp)
      return true if candidate[:cost] <= current[:cost]
      return Math.exp((current[:cost] - candidate[:cost]) / temp) > rand()
    end

    # search
    def search(cities, max_iter, max_temp, temp_change)
      current = {:vector => shake(cities)}
      current[:cost] = cost(current[:vector], cities)
      temp, best = max_temp, current
      max_iter.times do |iter|
        candidate = get_neighbor(current, cities)
        temp = temp * temp_change
        current = candidate if should_accept?(candidate, current, temp)
        best = candidate if candidate[:cost] < best[:cost]
        if (iter + 1).modulo(10) == 0
          puts " > iter #{(iter + 1)}, best #{best[:cost]}"
        end
      end
      best
    end
  end
end
