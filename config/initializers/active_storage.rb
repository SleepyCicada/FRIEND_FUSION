# Disable automatic image analysis
# This prevents ActiveStorage from trying to analyze images using libvips/ImageMagick
# which aren't available on Heroku by default.
# Since we're using Cloudinary and not creating image variants, analysis isn't needed.

Rails.application.config.after_initialize do
  ActiveStorage::Attachment.class_eval do
    after_create_commit -> { analyze_later if should_analyze? }

    private

    def should_analyze?
      # Skip analysis in production (Heroku) where image processing libraries aren't installed
      # Analysis is only needed if you're creating variants (resizing, transforming)
      !Rails.env.production?
    end
  end
end
