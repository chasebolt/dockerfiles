require 'open-uri'
require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = ENV['IRC_NICK']
    c.server = ENV['IRC_SERVER']
    c.port = ENV['IRC_PORT']
    c.ssl.use = true if ENV['IRC_SSL'] == 'true'
    c.channels = ENV['IRC_CHANNELS'].split(',').map(&:strip)
  end

  helpers do
    def shorten(url)
      url = open("https://tinyurl.com/api-create.php?url=#{URI.escape(url)}").read
      url == 'Error' ? nil : url
    rescue OpenURI::HTTPError
      nil
    end
  end

  on :channel do |m|
    return if m.message.length <= 60
    urls = URI.extract(m.message, %w(http https))

    unless urls.empty?
      short_urls = urls.map { |url| shorten(url) }.compact
      m.reply short_urls.join(', ') unless short_urls.empty?
    end
  end
end

bot.start
