json.atmospheres @atmospheres do |atmosphere|
  json.id atmosphere.id
  json.label atmosphere.label
  json.color atmosphere.color
  json.icon atmosphere.try(:svg_icon)
  json.opuses_count atmosphere.opuses_count
end
