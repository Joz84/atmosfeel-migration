class Front::ExperienceController < Front::CatalogController
  private

  def pre_filtered_opuses
    Opus.experience
  end

  def opuses_experience_param
    true
  end
end
