module MoviesHelper
  def next_sort_direction(column)
    current_sort = session[:sort]
    current_dir  = session[:direction]

    if column.to_s == current_sort.to_s
      case current_dir
      when 'asc'  then 'desc'
      when 'desc' then 'none'
      else             'asc'
      end
    else
      'asc'
    end
  end

  def sort_arrow(column)
    return '' unless column.to_s == session[:sort].to_s
    case session[:direction]
    when 'asc'  then '↑'
    when 'desc' then '↓'
    else ''
    end
  end

  def highlight_column?(column)
    session[:sort].to_s == column.to_s && session[:direction] != 'none'
  end
end