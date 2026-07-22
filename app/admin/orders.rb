ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :province_id, :order_number, :status, :subtotal, :gst_rate, :pst_rate, :hst_rate, :gst_amount, :pst_amount, :hst_amount, :tax_total, :grand_total, :address_line_1, :address_line_2, :city, :postal_code, :province_name, :paid_at

  index do
    selectable_column
    id_column
    column :order_number
    column :user
    column :status
    column :province_name
    column :subtotal
    column :tax_total
    column :grand_total
    column :paid_at
    column :created_at
    actions
  end

  filter :order_number
  filter :user
  filter :status
  filter :province_name
  filter :grand_total
  filter :paid_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :province
      f.input :order_number
      f.input :status
      f.input :subtotal
      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
      f.input :gst_amount
      f.input :pst_amount
      f.input :hst_amount
      f.input :tax_total
      f.input :grand_total
      f.input :address_line_1
      f.input :address_line_2
      f.input :city
      f.input :postal_code
      f.input :province_name
      f.input :paid_at
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :order_number
      row :user
      row :province
      row :status
      row :subtotal
      row :gst_rate
      row :pst_rate
      row :hst_rate
      row :gst_amount
      row :pst_amount
      row :hst_amount
      row :tax_total
      row :grand_total
      row :address_line_1
      row :address_line_2
      row :city
      row :postal_code
      row :province_name
      row :paid_at
      row :created_at
      row :updated_at
    end
    #
    # or
    #
    # permit_params do
    #   permitted = [:user_id, :province_id, :order_number, :status, :subtotal, :gst_rate, :pst_rate, :hst_rate, :gst_amount, :pst_amount, :hst_amount, :tax_total, :grand_total, :address_line_1, :address_line_2, :city, :postal_code, :province_name, :paid_at]
    #   permitted << :other if params[:action] == 'create' && current_user.admin?
    #   permitted
  end
end
