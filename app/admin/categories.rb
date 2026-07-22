ActiveAdmin.register Category do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :active
   index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    actions
  end

  filter :name
  filter :description
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :created_at
      row :updated_at
    end
    #
    # or
    #
    # permit_params do
    #   permitted = [:name, :description, :active]
    #   permitted << :other if params[:action] == 'create' && current_user.admin?
    #   permitted
  end
end
