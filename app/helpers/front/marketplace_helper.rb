module Front::MarketplaceHelper
  def body_class
    'experience'
  end

  def show_cart?
    true
  end

  def showing_price_sorting?
    true
  end

  def catalog_h1
    'Les œuvres auto-publiées'
  end 

  def front_catalog_path(params={})
    front_marketplace_path(params)
  end

  def front_catalog_link(params={})
    link_to t('front.menu.opuses_marketplace'), front_catalog_path(params)
  end

  def front_product_path(params={})
    front_marketplace_product_path(params)
  end

  def front_catalog_filter_path(params={})
    front_marketplace_filter_path(params)
  end

  private

  def asset_mask_diamond_path
    'mask-diamond.png'
  end

  def asset_mask_opus_path
    'mask-opus.png'
  end

  def image_tag_logo_name
    'atmosfeel-marketplace.png'
  end
end
