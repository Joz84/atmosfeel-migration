class Api::FilesController < ApiController
  def create
    uploaded_io = file_params
    uploaded_mimetype = uploaded_io.content_type

    if uploaded_mimetype.in?(media_types)
      directory_path = Rails.root.join('public', 'uploads', 'tmp')
      FileUtils.mkdir_p(directory_path) unless File.exists?(directory_path)
      uploaded_ext = File.extname(uploaded_io.original_filename)
      random_filename = "#{SecureRandom.urlsafe_base64}#{uploaded_ext}"
      full_path = Rails.root.join(directory_path, random_filename)
      File.open(full_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      render json: {path: "/uploads/tmp/#{random_filename}"}
    else
      render json: {}, status: 400
    end
  end

  private

  def file_params
    params.require(:file)
  end

  def media_types
    %w(
      audio/basic audio/L24 audio/mp4 audio/mp3 audio/ogg audio/mpeg audio/x-m4a audio/flac audio/opus
      audio/vorbis audio/vnd.rn-realaudio audio/vnd.wave audio/webm
      image/jpeg image/pjpeg image/png 
    )
  end
end