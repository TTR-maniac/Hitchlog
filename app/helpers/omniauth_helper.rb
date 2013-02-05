module OmniauthHelper
  def facebook_authentication
    link_to t('general.sign_up_with_facebook'), class: 'facebook_authentication'
  end

  def facebook_login
    link_to t('general.sign_in_with_facebook'), '/auth/facebook', :class => 'pretty_button'
  end
end
