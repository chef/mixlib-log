# Fail the suite on any Ruby warning raised from lib/, including
# deprecations, so they get fixed before a future Ruby turns them into errors.
Warning[:deprecated] = true

module RaiseOnLibraryWarnings
  LIB_DIR = File.expand_path("../../lib", __dir__)

  def warn(message, *args, **kwargs)
    raise message if message.include?(LIB_DIR)

    super
  end
end

Warning.singleton_class.prepend(RaiseOnLibraryWarnings)
