namespace :book_management do

  desc "sync book's status with stock level"

  task set_statuses: :environment do
    Book.all.each do |book|
      if book.update_status(book[:stock])
        puts "#{book[:title]}, by #{book[:author]}, ISBN: #{book[:isbn]} status updated to #{book[:status]}"
      end
    end
  end
end
