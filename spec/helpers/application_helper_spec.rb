require 'spec_helper'

describe ApplicationHelper do

  # def months_index_to_french_month(month_name)
  #   (%w[janvier février mars avril mai juin juillet août septembre octobre novembre décembre].index(month_name) || 0) + 1
  # end
  # 
  # 
  # def percentage_of_a_year(count)
  #   (count / 365.0 * 100).round(2)
  # end

  describe "today_index" do
    context "a Sunday" do
      around { |example| Timecop.travel(Time.utc(2012,3,11)) { example.call } }
      it { helper.today_index.should eq 0 }
    end

    context "a Monday" do
      around { |example| Timecop.travel(Time.utc(2012,3,12)) { example.call } }
      it { helper.today_index.should eq 1 }
    end

    context "a Saturday" do
      around { |example| Timecop.travel(Time.utc(2012,3,10)) { example.call } }
      it { helper.today_index.should eq 6 }
    end
  end

  describe "first_day_of_this_week" do
    context "a Sunday" do
      around { |example| Timecop.travel(Time.utc(2012,3,11)) { example.call } }
      it { helper.first_day_of_this_week.should eq Time.utc(2012,3,5) }
    end

    context "a Monday" do
      around { |example| Timecop.travel(Time.utc(2012,3,12)) { example.call } }
      it { helper.first_day_of_this_week.should eq Time.utc(2012,3,12) }
    end

    context "a Saturday" do
      around { |example| Timecop.travel(Time.utc(2012,3,10)) { example.call } }
      it { helper.first_day_of_this_week.should eq Time.utc(2012,3,5) }
    end
  end

  describe "first_day_of_last_week" do
    context "a Sunday" do
      around { |example| Timecop.travel(Time.utc(2012,3,11)) { example.call } }
      it { helper.first_day_of_last_week.should eq Time.utc(2012,2,27) }
    end

    context "a Monday" do
      around { |example| Timecop.travel(Time.utc(2012,3,12)) { example.call } }
      it { helper.first_day_of_last_week.should eq Time.utc(2012,3,5) }
    end

    context "a Saturday" do
      around { |example| Timecop.travel(Time.utc(2012,3,10)) { example.call } }
      it { helper.first_day_of_last_week.should eq Time.utc(2012,2,27) }
    end
  end

  describe "percentage_of_a_year" do
    it { helper.percentage_of_a_year(73).should eq 20 }
    it { helper.percentage_of_a_year(10).should eq (10.0/365 * 100).round(2) }
    it { helper.percentage_of_a_year(100).should eq (100.0/365 * 100).round(2) }
  end

end
