# frozen_string_literal: true

Decidim.content_blocks.register(:homepage, :enroll) do |content_block|
  content_block.cell = "decidim/content_blocks/enroll"
  content_block.public_name_key = "decidim.content_blocks.enroll.name"
  content_block.settings_form_cell = "decidim/content_blocks/enroll_settings_form"
  content_block.default!
  content_block.settings do |settings|
    settings.attribute :button_url, type: :string
  end
end

Decidim.content_blocks.register(:homepage, :call_to_join) do |content_block|
  content_block.cell = "decidim/content_blocks/call_to_join"
  content_block.public_name_key = "decidim.content_blocks.call_to_join.name"
  content_block.settings_form_cell = "decidim/content_blocks/call_to_join_settings_form"
  content_block.default!
  content_block.settings do |settings|
    settings.attribute :button_url, type: :string
  end
end

Decidim.content_blocks.register(:homepage, :welcome) do |content_block|
  content_block.cell = "decidim/content_blocks/welcome"
  content_block.public_name_key = "decidim.content_blocks.welcome.name"
  content_block.settings_form_cell = "decidim/content_blocks/welcome_settings_form"
  content_block.default!
  content_block.settings do |settings|
    settings.attribute :button_url, type: :string
  end
end

Decidim.content_blocks.register(:participatory_process_group_homepage, :processes_list) do |content_block|
  content_block.cell = "decidim/content_blocks/processes_list"
  content_block.public_name_key = "decidim.content_blocks.processes_list.name"
  content_block.settings_form_cell = "decidim/content_blocks/processes_list_settings_form"
  content_block.default!
  content_block.settings do |settings|
    settings.attribute :title_text, type: :string
    settings.attribute :description_text, type: :string
    settings.attribute :subtitle_text, type: :string
    settings.attribute :button_text, type: :string
    settings.attribute :button_url, type: :string
  end
end
