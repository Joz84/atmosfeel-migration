json.languages @languages do |language|
  json.id language.id
  json.label language.label
  json.opuses_count language.opuses_count
end
