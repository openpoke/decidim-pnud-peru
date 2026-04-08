# frozen_string_literal: true

Decidim.content_blocks.register(:homepage, :enroll) do |content_block|
  content_block.cell = "decidim/content_blocks/enroll"
  content_block.public_name_key = "decidim.content_blocks.enroll.name"
  content_block.default!
end

