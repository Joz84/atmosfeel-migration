class Front::MarketplaceController < Front::CatalogController
  private

  def pre_filtered_opuses
    Opus.marketplace
  end

  def opuses_experience_param
    false
  end
end
