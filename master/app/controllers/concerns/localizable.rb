module Localizable
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
  end

  private

  def switch_locale(&)
    I18n.with_locale(valid_locale, &)
  end

  def valid_locale
    locale = current_user&.locale || params[:locale]
    I18n.available_locales.include?(locale.try(:to_sym)) ? locale : I18n.default_locale
  end
end
