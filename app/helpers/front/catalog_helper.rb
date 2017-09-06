module Front::CatalogHelper
  def add_class?(bool, klass)
    bool ? klass : ''
  end

  def showing_price_sorting?
    false
  end

  def catalog_h1
    'Les œuvres AtmosFeel'
  end 

  def all_atmosphere_active
    params_filter_atmosphere_id.empty? ? 'active' : ''
  end
end
