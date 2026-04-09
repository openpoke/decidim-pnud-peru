# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class ProcessesListCell < Decidim::ViewModel
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
    end
  end
end
