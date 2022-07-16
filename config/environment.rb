# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Make 'field_with_error' class not being created
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
