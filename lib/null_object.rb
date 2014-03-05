class NullObject
  def initialize
    @origin = caller.first
  end

  def method_missing(*args, &block)
    self
  end

  def !; true; end
  def blank?; true; end
  def empty?; true; end
  def nil?; true; end

  def any?; false; end
  def present?; false; end

  def to_a; []; end
  def to_ary; []; end
  def to_s; ""; end
  def to_f; 0.0; end
  def to_i; 0; end
end

def Maybe(value)
  value.nil? ? NullObject.new : value
end
