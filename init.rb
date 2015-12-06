Redmine::Plugin.register :redmine_dropbox_link do
  name 'Redmine Dropbox Link plugin'
  author 'BILEL KEDIDI'
  description 'This is a plugin o replace Files link to redirect it to Dropbox'
  version '0.0.1'
end

Rails.application.config.to_prepare do
  module Redmine
    module MenuManager
      module MenuHelper
        def self.included(base)
          base.class_eval do
            alias_method_chain :render_menu, :new
          end
        end

        def render_menu_with_new(menu, project=nil)
          if project
            begin
              value = project.custom_field_values.select{|cfv| cfv.custom_field.name == "Dropbox link"}.first.value
            rescue
              value = ""
            end
          end
          links = []
          menu_items_for(menu, project) do |node|
            if node.children.present? || !node.child_menus.nil?
              links << render_menu_node(node, project)
            else
              if node.url.is_a?(Hash) and node.url.stringify_keys['controller'] == 'files' && value.to_s.present?
                caption, url, selected = extract_node_details(node, project)
                links<< content_tag('li',render_single_menu_node(node, caption, value, selected))
                next
              end
              links << render_menu_node(node, project)
            end
          end
          links.empty? ? nil : content_tag('ul', links.join("\n").html_safe)
        end

      end
    end
  end
end

