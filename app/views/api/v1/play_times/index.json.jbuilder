json.play_times @play_times do |play_time|
  json.id play_time.id
  json.label play_time.label
  json.opuses_count play_time.opuses_count
end
