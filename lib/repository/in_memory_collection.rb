class InMemoryCollection < Array
  def <<(element)
    super(element) unless include?(element)
  end
end
