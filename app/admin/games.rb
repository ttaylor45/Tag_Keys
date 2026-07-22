ActiveAdmin.register Game do
   # See permitted parameters documentation:
   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
   #
   # Uncomment all parameters which should be permitted for assignment
   #
   permit_params :steam_app_id, :category_id, :title, :description, :price, :sale_price, :developer, :publisher, :release_date, :active, :featured, :header_image_url
    index do
    selectable_column
    id_column
    column :title
    column :category
    column :price
    column :sale_price
    column :active
    column :featured
    actions
  end

  filter :title
  filter :category
  filter :active
  filter :featured

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :category
      f.input :steam_app_id
      f.input :developer
      f.input :publisher
      f.input :price
      f.input :sale_price
      f.input :release_date
      f.input :active
      f.input :featured
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :description
      row :category
      row :steam_app_id
      row :developer
      row :publisher
      row :price
      row :sale_price
      row :release_date
      row :active
      row :featured
      row :created_at
      row :updated_at
    end
    #
    # or
    #
    # permit_params do
    #   permitted = [:steam_app_id, :category_id, :title, :description, :price, :sale_price, :developer, :publisher, :release_date, :active, :featured, :header_image_url]
    #   permitted << :other if params[:action] == 'create' && current_user.admin?
    #   permitted
  end
end
