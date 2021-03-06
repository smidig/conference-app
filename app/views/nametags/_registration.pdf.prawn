require 'prawn/layout'
require 'prawn/format'


p_pdf.font_families.update(
    "League Gothic" => { :normal => "#{Rails.root}/public/stylesheets/League_Gothic-webfont.ttf" },
    "Blackout" => { :normal => "#{Rails.root}/public/stylesheets/Blackout-Midnight-webfont.ttf" }
)

p_pdf.font 'Blackout'
p_pdf.fill_color 'e4e0d7'
p_pdf.text '2016',
    :at => [20,-10],
    :overflow => :truncate,
    :size => 160

p_pdf.font 'League Gothic'
p_pdf.fill_color '110039'

name = registration.name
company = registration.company


unless registration.ticket.printname.blank?
  p_pdf.text registration.ticket.printname,
      :at => [189,20],
      :size => 36
end

p_pdf.fill_color 'FFFFFF'
p_pdf.table [[name]],
    :font_size  => 48,
    :horizontal_padding => 20,
    :vertical_padding => 50,
    :width => 297,
    :border_width => 0,
    :position => :left,
    :row_colors  => ['662d91']



p_pdf.move_up 30
p_pdf.fill_color '000000'
p_pdf.table [[company]],
    :font_size  => 20,
    :horizontal_padding => 20,
    :width => 297,
    :border_width => 0,
    :position => :left,
    :row_colors  => ['ffffff']


if registration.includes_dinner == true
  p_pdf.fill_color '000000'
  p_pdf.text 'Middag',
      :at => [5,5],
      :size => 14
elsif registration.includes_dinner == nil
  p_pdf.fill_color '000000'
  p_pdf.text '*',
      :at => [5,5],
      :size => 14
end
