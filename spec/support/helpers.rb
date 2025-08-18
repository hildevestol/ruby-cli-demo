# frozen_string_literal: true

module Helpers
  def file_count(dir_path)
    return 0 unless Dir.exist?(dir_path)

    Dir.entries(dir_path).count do |entry|
      File.file?(File.join(dir_path, entry))
    end
  end
end
