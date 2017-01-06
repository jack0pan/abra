require 'zip/zipfilesystem'

module Abra
  class Resource

    def initialize(apk_path)
      @apk = apk_path
    end

    def extract(res, dst)
      Zip::ZipFile.open(@apk).extract(res, dst)
    end

  end
end
