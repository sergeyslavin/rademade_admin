# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Input
    class RelatedSelectInput
      module RelatedList

        private

        def related_list_html
          template.content_tag(:ul, related_list_items_html, :class => 'select2-items-list')
        end

        def related_list_items_html
          serialized_values = Autocomplete::BaseSerializer.new(related_value).as_json
          html = serialized_values.map do |serialized_value|
            template.content_tag(:li, related_list_item_html(serialized_value), :'data-id' => serialized_value[:id])
          end
          RademadeAdmin::HtmlBuffer.new(html)
        end

        def related_list_item_html(serialized_value)
          RademadeAdmin::HtmlBuffer.new([
            related_list_item_title_html(serialized_value),
            related_list_item_edit_html(serialized_value),
            related_list_item_remove_html
          ])
        end

        def related_list_item_title_html(serialized_value)
          template.content_tag(:span, serialized_value[:text])
        end

        def related_list_item_edit_html(serialized_value)
          template.content_tag(:button, I18n.t('rademade_admin.edit'), :'data-edit' => serialized_value[:edit_url])
        end

        def related_list_item_remove_html
          template.content_tag(:button, I18n.t('rademade_admin.destroy'), :'data-remove' => '')
        end

        def related_list_link_html
          if multiple?
            relation_name = RademadeAdmin::Model::Graph.instance.model_info(related_to).item_name
            url = admin_related_item(model, relation_getter)
            template.content_tag(:a, relation_name, {
              :href => url,
              :class => 'related-link'
            }) + related_list_html if url
          end
        end

      end
    end
  end
end