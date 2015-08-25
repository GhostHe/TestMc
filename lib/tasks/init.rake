
namespace :init do
  desc 'init data'
  task :aquos_series => :environment do
    require 'spreadsheet'
    ActiveRecord::Base.connection.execute "truncate table aquos_series"
    aps = AquosProduct.find(:all).group_by(&:name)

    aps.each do |k, v|
      if k == "NX255A"
        inches = v[0..2].map(&:inch).join("/")
        as = AquosSeries.create(
          :name => k,
          :inches =>  inches,
          :short_desc => "#{inches} 对应4K分辨率，大画面，贵丽泷四色技术 / Quattron 3D"
        )
        v[0..2].each do |ap|
          ap.update_attribute(:aquos_series_id, as.id)
        end
        inches = v[3..3].map(&:inch).join("/")
        as = AquosSeries.create(
          :name => inches + k,
          :inches =>  inches,
          :short_desc => "#{inches} 对应4K分辨率，大画面，贵丽泷四色技术 / Quattron 3D"
        )
        v[3..3].each do |ap|
          ap.update_attribute(:aquos_series_id, as.id)
        end
      else
        inches = v.map(&:inch).join("/")
        as = AquosSeries.create(
          :name => k,
          :inches =>  inches,
          :short_desc => "#{inches} 对应4K分辨率，大画面，贵丽泷四色技术 / Quattron 3D"
        )
        v.each do |ap|
          ap.update_attribute(:aquos_series_id, as.id)
        end
      end
    end #aps.each

    file = File.join(Rails.root, "doc", "aquos_product_specification.xls")
    open_book = Spreadsheet.open(file)
    c0 = open_book.worksheets[2].column(0)

  end
end