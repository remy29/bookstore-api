ActiveAdmin.register Book do
  permit_params :title, :author, :isbn, :status, :stock
end
