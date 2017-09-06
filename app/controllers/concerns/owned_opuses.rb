module OwnedOpuses
  extend ActiveSupport::Concern

  included do 
    before_filter :set_owned_opuses_ids, :set_library_opuses_ids, :set_participated_opuses_ids
    helper_method :owned_opus, :library_opus, :agreement_active?, :participated_opus, :can_read, :can_edit
  end

  def can_read(opus_id)
    owned_opus(opus_id) || library_opus(opus_id) || participated_opus(opus_id) || agreement_active?
  end

  def can_edit(opus)
    if user_signed_in?
      opus.user_id == current_user.id
    else
      false
    end
  end

  def owned_opus(opus_id)
    @owned_opuses_ids.include?(opus_id)
  end

  def library_opus(opus_id)
    @library_opuses_ids.include?(opus_id)
  end

  def participated_opus(opus_id)
    @participated_opuses_ids.include?(opus_id)
  end

  def agreement_active?
    if user_signed_in?
      current_user.agreement_active?
    else
      false
    end
  end

  private 

  def set_participated_opuses_ids
    if user_signed_in?
      @participated_opuses_ids = current_user.participated_opuses_ids
    else
      @participated_opuses_ids = []
    end
  end

  def set_library_opuses_ids
    if user_signed_in?
      @library_opuses_ids = current_user.library_entries_opuses_ids
    else
      @library_opuses_ids = []
    end
  end

  def set_owned_opuses_ids
    if user_signed_in?
      @owned_opuses_ids = current_user.owned_opuses_ids
    else
      @owned_opuses_ids = []
    end
  end
end