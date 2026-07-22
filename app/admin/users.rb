ActiveAdmin.register User do
  permit_params :email,
                :username,
                :first_name,
                :last_name,
                :address_line_1,
                :address_line_2,
                :city,
                :postal_code,
                :province_id,
                :role

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :first_name
    column :last_name
    column :province
    column :role
    column :created_at
    actions
  end

  filter :username
  filter :email
  filter :first_name
  filter :last_name
  filter :province
  filter :role
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :first_name
      f.input :last_name
      f.input :address_line_1
      f.input :address_line_2
      f.input :city
      f.input :postal_code
      f.input :province
      f.input :role
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :username
      row :first_name
      row :last_name
      row :address_line_1
      row :address_line_2
      row :city
      row :postal_code
      row :province
      row :role
      row :created_at
      row :updated_at
    end
  end
end
