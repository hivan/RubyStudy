class Person
  def anyone_can_access_this; ...; end
  def this_is_private; ...; end
  def this_is_also_private; ...; end
  def another_public_method; ...; end

  private :this_is_private, :this_is_also_private
end
