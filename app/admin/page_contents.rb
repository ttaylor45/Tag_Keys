ActiveAdmin.register PageContent do
  menu label: "Pages"

  permit_params :page_key, :title, :body

  index do
    selectable_column
    id_column
    column :page_key
    column :title
    column :updated_at
    actions
  end

  filter :page_key
  filter :title
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Page Content" do
      f.input :page_key
      f.input :title
      f.input :body, as: :text,
                     input_html: { rows: 15 }
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :page_key
      row :title
      row :body do |page|
        simple_format(page.body)
      end
      row :created_at
      row :updated_at
    end
  end
end