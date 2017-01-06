require 'spec_helper'

describe Abra do
  before do
    @apks_path = "/backup/installers"
  end

  it 'has a version number' do
    expect(Abra::VERSION).not_to be nil
  end

  it "parse one apk" do
    apk_path = File.expand_path(File.dirname(__FILE__) + '/data/ieterm.apk')
    apk = Abra::APK.new(apk_path)
    icon_file = apk.icon_file
    expect(icon_file).not_to eq(nil)
    expect(apk.package).to eq('com.icefireym.ieterm')
    expect(apk.version_name).to eq('1.0')
    expect(apk.version_code).to eq(1)
    expect(apk.label).to eq('iEterm')
    expect(apk.api_level).to eq(10)
  end
end
