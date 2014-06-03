require 'spec_helper'

describe PhotoSet do
  let(:photoset) { PhotoSet.new(nil) }

  describe "skipped_photos_count_since" do
    before { photoset.stub(:size).and_return(1) }

    it { photoset.skipped_photos_count_since(Time.now.utc).should eq 0 }
    it { photoset.skipped_photos_count_since(1.day.ago).should eq 0 }
    it { photoset.skipped_photos_count_since(2.days.ago).should eq 1 }
  end

end
