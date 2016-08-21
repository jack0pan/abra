module Abra
  class AAPT
    def self.exec(command, apk)
      `#{self.aapt} #{command} #{apk}`
    end

    def self.dump_badging(apk)
      attrs = {}
      info = self.exec('dump badging', apk)
      package = info.match(/package:\s*(.*)/)[1] rescue nil
      application = info.match(/application:\s*(.*)/)[1] rescue nil
      attrs[:package] = package.match(/name='([^']*)'/)[1] rescue nil
      attrs[:version_code] = package.match(/versionCode='([^']*)'/)[1] rescue nil
      attrs[:version_name] = package.match(/versionName='([^']*)'/)[1] rescue nil
      attrs[:label] = info.scan(/application-label-zh:\s*'([^']*)'/)[0]
      if not attrs[:label] or attrs[:label].length == 0
        m = info.scan(/label='([^']*)'/)
        attrs[:label] = self.parse(m)
      end
      attrs[:icon] = application.match(/icon='([^']*)'/)[1] rescue nil
      attrs[:api_level] = info.match(/sdkVersion:\s*'(.*)'/)[1] rescue nil
      attrs
    end

    private
      def self.aapt
        aapt_path = File.dirname(__FILE__) + "/tool"
        if RUBY_PLATFORM =~ /win32/
        elsif RUBY_PLATFORM =~ /linux/
          bits = i.size * 8
          aapt_path = "#{aapt_path}/linux/#{bits}/aapt"
        elsif RUBY_PLATFORM =~ /darwin/
          aapt_path = "#{aapt_path}/macos/aapt"
        else
          puts "No aapt tools."
        end
        aapt_path
      end

      def self.parse(labels)
        if labels
          labels.each do |label|
            if label[0].length > 0
              return label[0]
            end
          end
        end
        return ''
      end
  end
end
