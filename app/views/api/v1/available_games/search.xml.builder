xml.instruct! :xml, :encoding => "UTF-8"
xml.classes do
  @ags.each do |ag|
    xml.class("", :classname => ag.course.name, :classid => ag.course.id, :classactive => "false") unless ag.course.nil?
  end
end