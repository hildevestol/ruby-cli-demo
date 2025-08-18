# frozen_string_literal: true

module Helpers
  # Has some helpers related to writing file
  class MdFile
    def write_with_timestamp(name:, content:)
      directory_path = "md_files/#{ENV.fetch('APP_ENV', nil)}/#{name}"
      FileUtils.mkdir_p(directory_path) unless File.directory?(directory_path)
      File.write("#{directory_path}/#{name}_#{Time.now.to_i}.md", content)
    end
  end
end
