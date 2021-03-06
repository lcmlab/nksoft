# coding: utf-8

module ApplicationHelper
   def page_title
      title = "勤務管理システム"
      title = @page_title + "-" + title if @page_title
      title
   end

   def menu_link_to(text, path)
      link_to_unless_current(text, path) { content_tag(:span, text) }
   end

end
