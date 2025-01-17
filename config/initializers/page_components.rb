Rails.application.config.page_components =
  ActiveSupport::HashWithIndifferentAccess.new({
    checkanswers: {
      input: %w(),
      content: %w(content)
    },
    confirmation: {
      input: %w(),
      content: %w(content)
    },
    content: {
      input: %w(),
      content: %w(content)
    },
    multiplequestions: {
      input: %w(text textarea number date radios checkboxes),
      content: %w(content)
    },
    singlequestion: {
      input: %w(text textarea number date radios checkboxes),
      content: %w()
     }
  })
