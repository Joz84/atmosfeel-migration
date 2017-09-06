namespace :system do
  task :clean_tmp do
    root_path = Rails.root.join('public', 'uploads', 'tmp')
    files = Dir.entries(root_path).drop_while {|file| 
      File.mtime(Rails.root.join('public', 'uploads', 'tmp', file)).today?
    }
    files.each {|file| 
      file_path = Rails.root.join('public', 'uploads', 'tmp', file)
      FileUtils.rm_rf(file_path) if File.file?(file_path)
    }
  end
end