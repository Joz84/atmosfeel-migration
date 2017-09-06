module Back::OpusesHelper
  def opus_li_class(opus)
    if opus.flagged?
      'list-group-item-danger'
    elsif opus.published?
      'list-group-item-success'
    else
      'list-group-item-warning'
    end
  end

  def opus_path(opus)
    back_opuses_path
  end
end
