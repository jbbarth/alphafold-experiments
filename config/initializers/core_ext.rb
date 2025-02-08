Rails.autoloaders.main.ignore(Rails.root.join("lib/core_ext"))
Dir.glob("#{Rails.root}/lib/core_ext/*.rb").each do |file|
  require file
end
