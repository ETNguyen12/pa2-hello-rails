module ApplicationHelper
    # Determine the next sorting direction (asc -> desc -> nil)
    def next_direction(column)
      if @sort == column
        case @direction
        when 'asc'
          'desc'
        when 'desc'
          nil # No sorting
        else
          'asc'
        end
      else
        'asc' # Default to ascending if sorting a new column
      end
    end
  
    # Display the current sort indicator (⬆, ⬇, or blank)
    def sort_indicator(column)
      return '⬆' if @sort == column && @direction == 'asc'
      return '⬇' if @sort == column && @direction == 'desc'
      '' # No indicator if no sorting
    end
  end  