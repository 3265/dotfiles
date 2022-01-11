# -*- coding: utf-8 -*-
ARGF.each do |line|
  line.gsub!("■・", "\\n・")
  line.gsub!(/■/, '')
  attr = nil
  line.sub!(/  \{(.+?)\}/) do |e|
    attr = $1
    ''
  end
  key, content = line.split(' : ')
  content = "【#{attr}】" << content if attr
  puts [key, content].join("\t")
end

