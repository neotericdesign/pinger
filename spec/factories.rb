Factory.define :site do |f|
  f.url    "http://www.example.com"
  f.name   "Example Site"
end

Factory.define :attempt do |f|
  f.association :site
  f.success     true
end
