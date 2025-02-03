module ApplicationHelper
  def link_to_section(title, target, opts = {})
    current = false
    if target == "/" && controller.controller_name == "welcome"
      current = true
    else
      current = (target == "/#{controller.controller_name}")
    end
    classes = (opts.delete(:class) || "").split
    classes << "current" if current
    link_to(title, target, class: classes, **opts)
  end

  def hidable_image_tag(src, **kwargs)
    if incognito_mode && !src.starts_with?("https://placehold.co/")
      image_tag("https://placehold.co/600x300", **kwargs)
    else
      image_tag(src, **kwargs)
    end
  end

  def display_special_filter(name, value, current: nil, display: nil)
    current ||= request.params[name]
    selected = current == value
    display ||= value

    classes = %w(px-1)
    if selected
      classes += %w(bg-blue-300 border border-blue-400)
    else
      classes += %w(bg-slate-200 hover:bg-blue-200 border border-slate-300)
    end

    link_to display, request.params.merge(name => (selected ? "" : value)), class: classes
  end
end
