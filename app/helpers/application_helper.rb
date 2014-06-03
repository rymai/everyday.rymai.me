# coding: utf-8
module ApplicationHelper

  def months_index_to_french_month(month_name)
    (%w[janvier février mars avril mai juin juillet août septembre octobre novembre décembre].index(month_name) || 0) + 1
  end

  def today_index
    Date.today.wday
  end

  def first_day_of_this_week
    today_index.zero? ? 6.days.ago.midnight : (today_index - 1).days.ago.midnight
  end

  def first_day_of_last_week
    first_day_of_this_week - 7.days
    # (13 + today_index).days.ago.midnight
  end

  def fraction_of_a_year(count)
    (count / 365.0).round(2)
  end

  def percentage_of_a_year(count)
    (count / 365.0 * 100).round(2)
  end

  def time_spent_taking_pictures(count)
    # we suppose I took 20 seconds per picture...
    from_time = Time.now
    distance_of_time_in_words(from_time, from_time + (count * 20).seconds)
  end

end
