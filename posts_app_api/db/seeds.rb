# frozen_string_literal: true

puts 'Seeding users'

test_user = User.create!(name: 'Test User', email: 'user@example.com')

first_names = ['Peter','Myles','Michael','Craig','Richard','Clive','Errol','Macdonald','Simon','Andrew','Richard','Wayne','Philip','Roy','Ramon','John','Steve','Scott','Andrew','John','Keith','Keith','Derek','Richard','Francis','James','Bernard','Liam','Christoph','Noel','Martin','Adam','Eric','Neil','Phillip','Sardar','Nicholas','Ian','Craig','Ronald','Brian','Maurice','Richard','John','Luke','Robert','Steve','Alasdair','David','Giles','Kevin','Bob','Thomas','Mark','Geoff','Kevin','Sean','Keith','Christopher','Kent','Paul','Michael','Peter','Morag','Mark','Sayfur','Arthur','Mike','Philip','Jonathan','Christopher','Alan','Stevie','Daniel','Ben','Adam','Anthony','Peter','Gary','Andrew','Nicholas','John','John','Paul','Anthony','Richard','Simon','Paul','Derek','Richard','Stephen','Alexander','James','Chrustopher','Benjamin','Alan','Leigh','Simon','George','Joel','Susan','Sharleen','Aditi','Julie','Viktoria','Ew','Alison','Melanie','Alison','Caroline','Mary','Gillian','Jeanette','Sharon','Diane','Karen','Jodie','Rosalie','Susan','Katharine','Rosemary','Gillian','Fiona','Lucy','Iwona','Angela','Jennifer','Janet','Vera','Kirsty','Tracey','Sally','Maura','Linda','Linda','Bernadette','Vandana','Ladan','Nicola','Lorna','Jacqueline','Allison','Martha','Maureen','Fang','Carol','Anne','Jayne','June','Sarah','Joanne','Rosie','Anne','Carolyn','Trudy','Monica','Lynne','Sarah','Jacqueline','Sheila','Charlotte','Hilary','Marjory','Kellie','Sue','Helen','Debora','Jade','Mandy','Mari','Victoria','Gillian','Edith','Evelyn','Jennifer','Karen','Susan','Jane','Elaine','Susan','Colette','Linda','Michelle','Emma','Rachael','Elizabeth','Susan','Dorothy','Sandra','Carol','Julie','Lindsey','Alison','Hayley','Victoria','Anne','April','Shirley','Shirley','Lindsey']
last_names = ['Adler','Ashby','Atherton','Atkinson','Bailey','Baron','Barton','Bell','Bodily','Brent','Brown','Bullock','Cain','Cann','Catchpole','Chick','Collins','Coventry','Cowan','Ennis','Facey','Fearn','Geary','Gill','Gordon','Grafton','Graham','Guilfoyle','Gunter','Hand','Harrison','Harvey','Hewett','Holmes','Humphrey','Hussain','Irish','Jackson','Jeavons','Jenkins','Johnstone','Jones','Kelso','King','Kitchen','Legge','Littlewood','MacIver','Manning','Mason','McArthur','McIlroy','McKenna','McVeigh','Meacham','Medcalf','Mellor','Middleton','Ness','Pattinson','Payne','Port','Pound','Prior','Pugh','Rahman','Rimmer','Robertson','Robinson','Rogan','Rowell','Sadler','Shindler','Short','Smith','Smith','Snook','Spence','Stafford','Starling','Starling','Stevens','Stevens','Stokes','Stringer','Stubbins','Tait','Templeton','Thomas','Thomas','Vincent','Walker','Walker','Warren','Wheeldon','Wick','Williams','Williams','Wilson','Yang','Alexander','Archer','Arora','Asbury','Baker','Barclay','Bell','Berry','Bex','Bolger','Brady','Brown','Brown','Brownlie','Buxton','Carter','Chandler','Chell','Clarkson','Collins','Conteh','Cross','Curtis','Cutforth','Dunsford','Durrant','Edwards','Evans','Flaxman','Foster','Galt','Geer','Gittins','Gourlay','Greenhalgh','Griffith','Gupta','Hall','Hankey','Hanson','Harris','Hindle','Hocking','Houston','Huang','Hunt','Ireland','Jenkins','Johnson','Johnson','Johnson','Jones','Jules','Kirkby','Knight','Lambert','Lawrence','Lawrence','Lloyd','Luck','McBride','McGrath','McIntyre','Miller','Mitchell','Mitchell','Moretti','Murphy','Nash','Odell','Osler','Padgett','Pain','Parkin','Pollard','Poole','Potts','Pratley','Prince','Rawlings','Rayson','Riley','Riley','Roberts','Ross','Sanders','Saunders','Scully','Shaw','Smith','Smith','Stamp','Stewart','Thacker','Tierney','Tweddle','Twigg','Vernon','Wells','Williams']

100.times do |index|
  names = [first_names.sample, last_names.sample]
  User.create!(name: names.join(' '), email: "#{names.map(&:downcase).join('.')}.#{index}@example.com")
end

puts 'Seeding posts'

post_texts = [
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  'Vitae congue mauris rhoncus aenean vel elit.',
  'Lectus proin nibh nisl condimentum id venenatis a.',
  'Quis risus sed vulputate odio ut enim.',
  'Enim lobortis scelerisque fermentum dui faucibus in ornare.',
  'Volutpat commodo sed egestas egestas fringilla.',
  'Mattis aliquam faucibus purus in.',
  'Id diam vel quam elementum pulvinar.',
  'In egestas erat imperdiet sed euismod nisi porta lorem.',
  'Nibh praesent tristique magna sit amet purus gravida.',
  'Id donec ultrices tincidunt arcu non.',
  'Ac auctor augue mauris augue neque gravida in fermentum et.',
  'Pellentesque pulvinar pellentesque habitant morbi tristique senectus.',
  'Quis viverra nibh cras pulvinar mattis nunc sed.',
  'Cursus eget nunc scelerisque viverra mauris in.',
  'Eget lorem dolor sed viverra ipsum.',
  'Tristique et egestas quis ipsum suspendisse ultrices gravida dictum fusce.',
  'Eget duis at tellus at.',
  'Vivamus arcu felis bibendum ut tristique et egestas quis.',
  'Feugiat nisl pretium fusce id velit ut tortor pretium.',
  'Consequat mauris nunc congue nisi vitae.',
  'Non pulvinar neque laoreet suspendisse interdum consectetur libero.',
  'Sollicitudin tempor id eu nisl nunc mi ipsum faucibus.',
  'Tortor condimentum lacinia quis vel eros donec.',
  'Netus et malesuada fames ac turpis egestas integer eget.',
  'Sem integer vitae justo eget magna fermentum.',
  'Posuere morbi leo urna molestie at.',
  'Nec nam aliquam sem et tortor consequat id porta nibh.',
  'Id donec ultrices tincidunt arcu non.',
  'Mattis molestie a iaculis at erat pellentesque adipiscing commodo.',
  'Dapibus ultrices in iaculis nunc.',
  'Ipsum suspendisse ultrices gravida dictum fusce ut placerat orci.',
  'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
  'Sed faucibus turpis in eu mi bibendum neque egestas.',
  'Augue ut lectus arcu bibendum at varius vel.',
  'Tortor id aliquet lectus proin.',
  'In nulla posuere sollicitudin aliquam ultrices sagittis orci a.',
  'Habitasse platea dictumst vestibulum rhoncus est.',
  'Amet luctus venenatis lectus magna.',
  'Purus viverra accumsan in nisl nisi scelerisque eu ultrices vitae.',
  'Elementum integer enim neque volutpat.',
  'Id eu nisl nunc mi ipsum faucibus vitae aliquet nec.',
  'Adipiscing diam donec adipiscing tristique risus nec.',
  'Et malesuada fames ac turpis.',
  'Vitae suscipit tellus mauris a diam maecenas.'
]

text_max_length = 3

1000.times do
  start_text_position = rand(post_texts.size - text_max_length - 1)
  end_text_position = start_text_position + rand(text_max_length) + 1
  text = post_texts[start_text_position..end_text_position].join(' ')

  Post.create!(body: text)
end

posts = Post.all

puts 'Seeding likes'

users = User.all.to_a

posts.each do |post|
  likes_count = rand(25)
  first_user_index = rand(users.size - 1 - likes_count)
  users_who_liked = users[first_user_index..first_user_index + likes_count]
  users_who_liked.each { |user| Like.create!(post: post, user: user) }

  # add likes for test use
  if rand(10) > 5 && !test_user.likes.where(post: post).exists?
    Like.create!(post: post, user: test_user)
  end
end

if ENV['SKIP_SEEDING_COMMENTS'] != '1'
  puts 'Seeding comments'

  comment_number = 1
  posts.each do |post|
    comments_count = rand(15)
    comments_count.times.each do |comment_index|
      user = users[comment_index % users.size]
      Comment.create!(post: post, user: user, body: "Comment ##{comment_number}")
      comment_number += 1
    end
  end
end
