module ApplicationHelper
  def used_class(score)
    !!score.used ? 'is-used' : 'is-dropped'
  end
end
