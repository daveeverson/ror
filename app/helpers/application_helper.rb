module ApplicationHelper

  def sd(d) # short_date
    d.to_date.strftime('%m/%d/%Y') if d.respond_to? :to_date
  end

  def row_class(index)
    index % 2 == 0 ? "rowodd":"roweven"
  end

end
