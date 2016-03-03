module UsersHelper
  def profile_tooltip
    info = []

    unless @user.gender.present?
      info << "#{t('users.edit.gender_html')} (+5%)"
    end

    unless @user.date_of_birth.present?
      info << "#{t('users.edit.date_of_birth_html')} (+10%)"
    end

    unless @user.country.present?
      info << "#{t('users.edit.country_html')} (+10%)"
    end

    unless @user.city.present?
      info << "#{t('users.edit.city_html')} (+10%)"
    end

    unless @user.phone_number.present?
      info << "#{t('users.edit.phone_number_html')} (+10%)"
    end

    unless @user.bio.present?
      info << "#{t('users.edit.bio_html')} (+15%)"
    end

    if info.blank?
      info << t('shared.personal_info.profile_completed')
    end

    info.join('<br>')
  end
end
