if Rails.env.development? && defined?(MrVideo)
  MrVideo.configure do |config|
    config.cassette_library_dir = 'spec/vcr_cassettes'
  end
end
