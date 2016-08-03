# A bucket for useful methods.
module Util
  class << self
    def normalize(val, from_low, from_high, to_low, to_high)
      (val - from_low) * (to_high - to_low) / (from_high - from_low).to_f
    end

    def decode_output(output)
      (0..9).max_by { |i| output[i] }
    end
  end
end
