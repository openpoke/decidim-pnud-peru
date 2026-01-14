# frozen_string_literal: true

namespace :pnud do
  desc "Import database"
  task import_database: :environment do
    puts "Going to import the folloding models:"
    puts "- Organization"
    puts "- Users"

    import_organizations
    import_users(import_dir)
  end

  desc "Import Organization"
  task import_organizations: :environment do
    import_organizations
  end

  desc "Import Users"
  task import_users: :environment do
    import_users
  end

  desc "Import Processes"
  task import_projects: :environment do
    import_projects
  end

  desc "Import Project Folders"
  task import_folders: :environment do
    import_folders
  end

  desc "Import Pages"
  task import_pages: :environment do
    import_pages
  end

  desc "Import Events"
  task import_events: :environment do
    import_events
  end

  desc "Import Ideas"
  task import_ideas: :environment do
    import_ideas
  end

  def import_organizations
    # organization = GovocalRecord.connection.exec_query("SELECT * FROM tenants")

    organization = Decidim::Organization.create!(host: "redpublica.pokecode.net", default_locale: :es, available_locales: [:es, :en], reference_prefix: "redpublica")
  end

  def import_users
    organization = Decidim::Organization.first

    already_exists = 0
    count = 0
    user_count = GovocalRecord.connection.select_value("SELECT count(*) FROM users")
    puts "Importing users: #{user_count}"

    users = GovocalRecord.connection.exec_query("SELECT * FROM users")
    users.each do |row|
      nickname = if row["slug"]
                   row["slug"]
                 elsif row["first_name"] || row["last_name"]
                   Decidim::UserBaseEntity.nicknamize("#{row["first_name"]} #{row["last_name"]}", organization.id)
                 else
                   Decidim::UserBaseEntity.nicknamize(row["id"], organization.id)
                 end

      nickname = nickname[0..19] if nickname.length > 20

      exists_user = Decidim::User.exists?(["email = :email OR nickname = :nickname", { email: row["email"], nickname: nickname }])
      if exists_user
        already_exists += 1
        next
      end

      user = Decidim::User.new(name: "#{row["first_name"]} #{row["last_name"]}", email: row["email"], nickname: nickname, organization: organization)

      user.skip_invitation = true
      user.invite!
      user.save
      count += 1
    end

    puts "Done importing users: #{count} - #{already_exists} already existed"
  end

  def import_folders
    organization = Decidim::Organization.first

    already_exists = 0
    count = 0

    folder_count = GovocalRecord.connection.select_value("SELECT count(*) FROM project_folders_folders")
    puts "Importing project folders #{folder_count}"

    folders = GovocalRecord.connection.exec_query("SELECT * FROM project_folders_folders")
    folders.each do |folder|
      Decidim::ParticipatoryProcessGroup.create!(
        title: { "es" => JSON.parse(folder["title_multiloc"])["es-CL"] },
        description: { "es" => JSON.parse(folder["description_multiloc"])["es-CL"] },
        organization:
      )

      count += 1
    end

    puts "Done importing folders: #{count} - #{already_exists} already existed"
  end

  def import_projects
    organization = Decidim::Organization.first

    already_exists = 0
    count = 0

    project_count = GovocalRecord.connection.select_value("SELECT count(*) FROM projects")
    puts "Importing projects: #{project_count}"

    projects = GovocalRecord.connection.exec_query("SELECT * FROM projects")
    projects.each do |project|
      params = {
        participatory_process: {
          title_es: JSON.parse(project["title_multiloc"])["es-CL"],
          subtitle_es: JSON.parse(project["title_multiloc"])["es-CL"],
          slug: project["slug"],
          description_es: JSON.parse(project["description_multiloc"])["es-CL"],
          short_description_es: JSON.parse(project["description_multiloc"])["es-CL"],
          current_organization: organization
        }
      }

      form = Decidim::ParticipatoryProcesses::Admin::ParticipatoryProcessForm.from_params(params).with_context(
        current_organization: organization,
        current_user: admin_user
      )

      Decidim::ParticipatoryProcesses::Admin::CreateParticipatoryProcess.call(form) do
        on(:ok) do
          count += 1
          next
        end

        on(:invalid) do
          next
        end
      end
    end

    puts "Done importing projects: #{count} - #{already_exists} already existed"
  end

  def import_pages
    organization = Decidim::Organization.first

    already_exists = 0
    count = 0

    pages_count = GovocalRecord.connection.select_value("SELECT count(*) from static_pages")
    puts "Importing static pages: #{pages_count}"

    static_pages = GovocalRecord.connection.exec_query("SELECT * FROM static_pages")
    static_pages.each do |static_page|
      title = JSON.parse(static_page["title_multiloc"])
      content = JSON.parse(static_page["top_info_section_multiloc"])

      title["es"] = title["es-CL"]
      content["es"] = content["es-CL"]
      slug = static_page["slug"]

      exists_page = Decidim::Pages.exists?(slug:)
      if exists_page
        already_exists += 1
        next
      end

      page = Decidim::StaticPage.create!(
        slug:,
        title:,
        content:,
        organization: organization,
        weight: 0
      )

      count += 1
    end

    puts "Done importing pages: #{count} - #{already_exists} already_existed"
  end

  def import_events
    organization = Decidim::Organization.first

    already_exists = 0
    count = 0

    events_count = GovocalRecord.connection.select_value("SELECT count(*) from events")
    puts "Importing static pages: #{events_count}"

    events = GovocalRecord.connection.exec_query("SELECT * FROM events")
    events.each do |static_page|
      # TODO:

      count += 1
    end

    puts "Done importing events: #{count} - #{already_exists} already_existed"
  end

  def import_ideas
    organization = Decidim::Organization.first

    already_exists = 0
    count = 0

    ideas_count = GovocalRecord.connection.select_value("SELECT count(*) from ideas")
    puts "Importing ideas: #{ideas_count}"

    # id title_multiloc body_multiloc publication_status published_at project_id author_id created_at updated_at likes_count dislikes_count
    # location_point location_description comments_count idea_status_id slug budget baskets_count official_feedbacks_count assignee_id assigned_at
    # proposed_budget custom_field_values                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 creation_phase_id           author_hash anonymous internal_comments_count votes_count followers_count submitted_at        manual_votes_amount manual_votes_last_updated_by_id manual_votes_last_updated_at neutral_reactions_count

    ideas = GovocalRecord.connection.exec_query("SELECT * FROM ideas")
    ideas.each do |idea|
      title = JSON.parse(idea["title_multiloc"])
      body = JSON.parse(idea["body_multiloc"])
      status = idea["publication_status"]
      published_at = idea["published_at"]
      project = idea["project_id"]
      slug = idea["slug"]
      location_point = idea["location_point"]

      sql = GovocalRecord.send(
        :sanitize_sql_array,
        ["SELECT * FROM projects WHERE id = ?", project]
      )

      project = GovocalRecord.connection.exec_query(sql).first
      participatory_process = Decidim::ParticipatoryProcess.find_by(slug: project["slug"])

      if participatory_process.components.exists?(manifest_name: "proposals")
        component = participatory_process.components.find_by(manifest_name: "proposals")
      else
        params = {
          name: "Propuestas",
          manifest_name: :proposals,
          published_at: Time.current,
          participatory_space: participatory_process
        }

        Decidim::Component.create!(params)
      end

      proposal = Decidim::Proposals::Proposal.create

      params = {
        title:,
        body:,
        author: admin_user
      }

      form = Decidim::Proposals::ProposalForm.from_params(params).with_context(
        current_component: component,
        current_organization: organization,
        current_user: admin_user
      )

      Decidim::Proposals::CreateProposal.call(form, admin_user) do
        on(:ok) do
          count += 1
          next
        end

        on(:invalid) do
          next
        end
      end

      count += 1
    end

    puts "Done importing pages: #{count} - #{already_exists} already_existed"
  end

  def admin_user
    Decidim::User.where(admin: true).first
  end
end
