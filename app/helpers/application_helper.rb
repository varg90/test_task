module ApplicationHelper
  def flash_class(type)
    {
      alert: 'alert-warning',
      notice: 'alert-info'
    }.fetch type.to_sym, type.to_s
  end
end
