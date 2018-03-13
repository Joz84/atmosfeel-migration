module FrontHelper
  def atmosphere_active(atmosphere_id)
    params_filter_atmosphere_id == atmosphere_id.to_s ? 'active' : ''
  end

  def body_class
    'experience'
  end

  def show_cart?
    false
  end

  # deal with this strange menu when the user logged in
  def open_menu
    session[:open_menu] ? 1 : 0
  end

  def opus_path(opus)
    if params.include?('back')
      front_opus_path(opus.id)
    elsif opus.atf_experience?
      front_experience_product_path(opus.id)
    else
      front_marketplace_product_path(opus.id)
    end
  end

  def cart_size
    if session[:cart_id].nil?
      0
    else
      begin
        cart = Cart.find_with_opuses(session[:cart_id])
        cart.opuses.length
      rescue ActiveRecord::RecordNotFound
        0
      end
    end
  end

  def front_catalog_path(params={})
    front_experience_path(params)
  end

  def front_catalog_link(params={})
    # link_to t('front.menu.experience'), front_catalog_path(params)
    link_to "Œuvres sélectionnées par AtmosFeel", front_catalog_path(params)
  end

  def front_product_path(params={})
    front_experience_product_path(params)
  end

  def front_catalog_filter_path(params={})
    front_experience_filter_path(params)
  end

  def image_tag_logo
    image_tag image_tag_logo_name
  end

  def asset_mask_diamond
    asset_path(asset_mask_diamond_path)
  end

  def asset_mask_opus
    asset_path(asset_mask_opus_path)
  end

  def params_filter_play_time_id
    params.has_key?(:filter) && !params[:filter].nil? ? (params[:filter][:play_time_id].nil? ? '' : params[:filter][:play_time_id]) : ''
  end

  private

  def asset_mask_diamond_path
    'mask-diamond-exp.png'
  end

  def asset_mask_opus_path
    'mask-opus-exp.png'
  end

  def image_tag_logo_name
    'atmosfeel-logo.png'
  end

  def params_filter_atmosphere_id
    params.has_key?(:filter) && !params[:filter].nil? ? (params[:filter][:atmosphere_id].nil? ? '' : params[:filter][:atmosphere_id]) : ''
  end
end
