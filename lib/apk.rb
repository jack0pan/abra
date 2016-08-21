require "abra/version"
require 'aapt'

module Abra
  class APK

    attr_reader :package, :version_name, :version_code, :label, :icon, :api_level

    def initialize(apk_path)
      @apk = apk_path
      attrs = Abra::AAPT.dump_badging(@apk)
      @package = attrs[:package]
      @version_name = attrs[:version_name]
      @version_code = attrs[:version_code].to_i
      @label = attrs[:label]
      @icon = attrs[:icon]
      @api_level = attrs[:api_level].to_i
    end

    def sdk_version
      case self.api_level
      when 8
        '2.2'
      when 9..10
        '2.3'
      when 11..13
        '3.0'
      when 14..15
        '4.0'
      when 16
        '4.1'
      when 17
        '4.2'
      end
    end

  end
end
