require "open-uri"

module Utils
  extend self

  def get_url(url)
    f = URI.open(url)
    begin
      f.set_encoding("UTF-8")
      return f.read.encode("UTF-8", "binary", invalid: :replace, undef: :replace, replace: "")
    ensure
      f.close
    end
  end
end
