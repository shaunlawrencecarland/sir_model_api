require_relative "point"

class Model
    attr_reader :eons, :susceptible, :infected, :resistant, :rate_si, :rate_ir
    
    def initialize(eons:, susceptible:, infected:, resistant:, rate_si:, rate_ir:)
      @eons = eons
      @susceptible = susceptible
      @infected = infected
      @resistant = resistant
      @rate_si = rate_si
      @rate_ir = rate_ir
    end

    def results
        @results ||= build_results
    end
  
    private

    def validate_params!
        raise InvalidArgsError if eons < 0
    end

    def build_results
      validate_params!
      point = Point.new(susceptible: susceptible, infected: infected, resistant: resistant, eon: 0)
      points = [point]
  
      eons.times do |eon|
        last_point = points.last
  
        s_to_i = (rate_si * last_point.susceptible * last_point.infected) / population_size
        i_to_r = last_point.infected - rate_ir
        
        point = Point.new(
          susceptible: last_point.susceptible - s_to_i,
          infected: last_point.infected + s_to_i - i_to_r,
          resistant: last_point.resistant + i_to_r,
          eon: eon
        )
  
        points << point
      end

      points.map { |point| point.to_json }
    end
    
    def population_size
      susceptible + infected + resistant
    end
  end

  class InvalidArgsError < StandardError
  end
