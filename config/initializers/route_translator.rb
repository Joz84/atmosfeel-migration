RouteTranslator.config do |config|
  # Set this options to true to force the locale to be hidden on generated route paths
  config.hide_locale = true
  # Set this option to true to add the behavior of force_locale, but with a named default route which behaves as if generate_unlocalized_routes was true
  # force_locale: Set this options to true to force the locale to be added to all generated route paths, even for the default locale
  # generate_unlocalized_routes: Set this option to true to add translated routes without deleting original unlocalized versions
  config.generate_unnamed_unlocalized_routes = true
end