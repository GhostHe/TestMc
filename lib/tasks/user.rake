
  namespace :user do
    desc "users data"
    task :user_infromation => :environment do
      require 'spreadsheet'
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet :name => 'test_mc users'
      users = User.all

      sheet1.row(0).concat %w{ID Name Email}
      users.each_with_index do |user,index|
        sheet1.row(index).height = 22
        sheet1[index+1,0]=user.id
        sheet1[index+1,1]=user.name
        sheet1[index+1,2]=user.email
      # user.each_with_index do |name,i|
      #   add_column(i)
      #   row(i){name,ixix}
        puts "#{user.name}"
      end
      FileUtils.mkdir_p "#{File.expand_path(Rails.root)}/public/excel" if !(File.exist?("#{File.expand_path(Rails.root)}/public/excel"))
      File.new("#{Rails.root}/public/excel/users_imformation.xls", "w+")
      book.write "#{Rails.root}/public/excel/users_imformation.xls"
    end


  end