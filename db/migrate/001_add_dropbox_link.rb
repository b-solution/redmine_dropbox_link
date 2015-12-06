class AddDropboxLink < ActiveRecord::Migration

  def change
    cf               = CustomField.new
    cf.type          = 'ProjectCustomField'
    cf.name          = 'Dropbox link'
    cf.field_format  = 'link'
    cf.is_required   = false
    cf.is_filter     = false
    cf.searchable    = true
    cf.editable      = true
    cf.visible       = true
    cf.multiple      = false
    cf.description   = "Link to drop box"
    cf.save

  end
end