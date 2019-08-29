# frozen_string_literal: true

class String
  def is_valid_number?
    pattern = /^\d*\.?\d+$/
    if pattern.match?(self)
      return true
    else
      puts 'Not a valid selection.'
      return false
    end
  end

  def is_y_or_n?
    pattern = /y|n/
    if pattern.match?(self)
      return true
    else
      puts 'Not a valid selection.'
      return false
    end
  end
end
