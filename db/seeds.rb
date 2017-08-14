# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ashby = User.create username: "ashby"

webpages = %w[
  https://blog.codinghorror.com/maybe-normalizing-isnt-normal/
  https://er.jsc.nasa.gov/seh/ricetalk.htm
  http://brianknapp.me/developers-dislike-agile/
  https://medium.com/@yonatanzunger/so-about-this-googlers-manifesto-1e3773ed1788
  https://blog.plan99.net/building-account-systems-f790bf5fdbe0
  http://nautil.us/issue/51/limits/emotional-intelligence-needs-a-rewrite
  http://blog.arkency.com/my-first-10-minutes-with-eventide/
  https://medium.com/@cindysridharan/small-functions-considered-harmful-91035d316c29
  https://electricliterature.com/the-rise-of-dystopian-fiction-from-soviet-dissidents-to-70s-paranoia-to-murakami-a73b945c5d37
  http://www.vanityfair.com/news/2017/07/department-of-energy-risks-michael-lewis
  https://hackernoon.com/artificial-intelligence-poker-and-regret-part-1-36c78d955720
  https://codingdelight.com/2014/01/17/favor-composition-over-inheritance-part-2/
  https://segment.com/blog/a-brief-history-of-the-uuid/
  https://aeon.co/essays/can-we-hope-to-understand-how-the-greeks-saw-their-world
  http://felixge.de/2017/07/27/implementing-state-machines-in-postgresql.html
  http://samizdat.cc/cyoa/
  https://www.brainpickings.org/2014/01/06/alan-watts-wisdom-of-insecurity-1/
  https://www.brainpickings.org/2015/03/05/franz-kafka-letter-father/
  http://www.meltingasphalt.com/a-nihilists-guide-to-meaning/
].map do |webpage|
  Webpage.find_or_create_by uri: webpage
end

webpages.sample(10).each do |webpage|
  ashby.bookmarks.find_or_create_by webpage: webpage
end
