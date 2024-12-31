module MoviesHelper
    def toggle_sort_direction(column)
      params[:sort] == column && params[:direction] == 'asc' ? 'desc' : 'asc'
    end
  
    def current_sort_class(column)
      if params[:sort] == column
        params[:direction] == 'asc' ? 'sorted-asc' : 'sorted-desc'
      end
    end
  end
  