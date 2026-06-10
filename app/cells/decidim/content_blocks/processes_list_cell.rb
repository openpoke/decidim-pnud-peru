# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class ProcessesListCell < Decidim::ViewModel
      def translate_title
        setting_text(:title_text, "decidim.content_blocks.processes_list_settings_form.title_text")
      end

      def translate_description
        setting_text(:description_text, "decidim.content_blocks.processes_list_settings_form.description_text")
      end

      def translate_subtitle
        setting_text(:subtitle_text, "decidim.content_blocks.processes_list_settings_form.subtitle_text")
      end

      def translate_button_text
        setting_text(:button_text, "decidim.content_blocks.processes_list_settings_form.button_text")
      end

      def participatory_processes
        id = params[:id]
        @process_group = Decidim::ParticipatoryProcessGroup.find(id)
        @process_group.participatory_processes.published
      end

      def resource_path(resource)
        resource_locator(resource).path
      end

      def process_image_url(process)
        process.attached_uploader(:hero_image).url
      end

      private

      def setting_text(field, fallback_key)
        value = model.settings.public_send(field)
        value = translated_attribute(value) if value.is_a?(Hash)

        value.presence || I18n.t(fallback_key, default: "")
      end
    end
  end
end
