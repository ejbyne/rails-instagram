module PicturesHelper

  def time_since_created(time_created)
    return pluralize((((Time.now - time_created) / 3600).round.to_s), 'hour') + " ago" if (Time.now - time_created) < 84600
    return pluralize((((Time.now - time_created) / 86400).round.to_s), 'day') + " ago" if (Time.now - time_created) < 2678400
    return pluralize((((Time.now - time_created) / 2678400).round.to_s), 'month') + " ago" if (Time.now - time_created) < 31536000
    pluralize((((Time.now - time_created) / 31536000).round.to_s), 'year') + " ago"
  end

end
