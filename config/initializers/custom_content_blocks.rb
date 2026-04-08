# frozen_string_literal: true

Decidim.content_blocks.register(:homepage, :enroll) do |content_block|
  content_block.cell = "decidim/content_blocks/enroll"
  content_block.public_name_key = "decidim.content_blocks.enroll.name"
  content_block.default!
end

Decidim.content_blocks.register(:homepage, :call_to_join) do |content_block|
  content_block.cell = "decidim/content_blocks/call_to_join"
  content_block.public_name_key = "decidim.content_blocks.call_to_join.name"
  content_block.default!
end

Decidim.content_blocks.register(:homepage, :welcome) do |content_block|
  content_block.cell = "decidim/content_blocks/welcome"
  content_block.public_name_key = "decidim.content_blocks.welcome.name"
  content_block.default!
end
