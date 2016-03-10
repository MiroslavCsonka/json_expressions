module JsonExpressions
  module Strict; end
  module Forgiving; end
  module Ordered; end
  module Unordered; end

  module CoreExtensions
    def ordered?
      is_a? Ordered
    end

    def unordered?
      is_a? Unordered
    end

    def ordered
      clone.ordered!
    end

    def unordered
      clone.unordered!
    end

    def ordered!
      if unordered?
        raise "cannot mark an unordered #{self.class} as ordered!"
      else
        extend Ordered
      end
    end

    def unordered!
      if ordered?
        raise "cannot mark an ordered #{self.class} as unordered!"
      else
        extend Unordered
      end
    end

    def strict?
      is_a? Strict
    end

    def forgiving?
      is_a? Forgiving
    end

    def strict
      clone.strict!
    end

    def forgiving
      clone.forgiving!
    end

    def strict!
      if forgiving?
        raise "cannot mark a forgiving #{self.class} as strict!"
      else
        extend Strict
      end
    end

    def forgiving!
      if strict?
        raise "cannot mark a strict #{self.class} as forgiving!"
      else
        extend Forgiving
      end
    end
  end
end

class Hash
  include JsonExpressions::CoreExtensions
  alias reject_extra_keys strict
  alias reject_extra_keys! strict!
  alias ignore_extra_keys forgiving
  alias ignore_extra_keys! forgiving!
end

class Array
  include JsonExpressions::CoreExtensions
  alias reject_extra_values strict
  alias reject_extra_values! strict!
  alias ignore_extra_values forgiving
  alias ignore_extra_values! forgiving!
end
