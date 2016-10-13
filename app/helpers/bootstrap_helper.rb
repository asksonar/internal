module BootstrapHelper
  # a more 'specific' version of navbar_item
  def bsh_navbar_item(display, url, active: true)
    is_active = active && request.path == url

    raw <<-HTML.chomp!
      <li class='#{is_active ? 'active' : ''}'><a href='#{url}'>#{display}</a></li>
    HTML
  end
end
