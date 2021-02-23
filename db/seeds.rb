# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or newd alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.new([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.new(name: 'Luke', movie: movies.first)

# Mettrer les news dans une variable pour pouvoir ajouter les ids
puts "Creation d'un député..."
representative = Representative.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  salutation: ["M", "Mme"].sample,
  email: Faker::Internet.email,
  circonscription_ref: "PO717752",
  circonscription_num: 2,
  city: "Condom",
  department: "Gers",
  region: "Occitanie",
  ref_num: "PA508",
  party: "Parti Socialiste",
  first_election?: false,
  hemicycle_seat: 515
)

representative.save!

puts "Creation d'une loi..."
law = Law.new(
  num: 3903,
  title: "Justice de proximité et réponse pénale",
  description:"Proposition de loi, modifiée par le Sénat, améliorant l'efficacité de la justice de proximité et de la réponse pénale",
)
law.representative = representative
law.save!

puts "Creation d'un utilisateur..."
user = User.new(
  email: Faker::Internet.email,
  password: "julien",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: "31 avenue Robert Schuman",
  zip: "92100",
  city: "Boulogne Billancourt",
  age: 25,
)

user.representative = representative
user.save!

 puts "Creation d'un vote d'un utilsateur..."
vote = UsersVote.new(
  voting_status: "for"
)

vote.law = law
vote.user = user
vote.save!

puts "Creation d'un commentaire..."
comment = Comment.new(
  title: "Very good idea",
  content: "J'espère que la loi va passer le plus rapidement possible. Ell va me changer la vie!",
  voting_status: "for"
)
comment.user = user
comment.law = law
comment.save!

puts "Creation d'un député..."
representative2 = Representative.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  salutation: ["M", "Mme"].sample,
  email: Faker::Internet.email,
  circonscription_ref: "PO718384",
  circonscription_num: 2,
  city: "Milly-la-Forêt",
  department: "Essonne",
  region: "Ile-de-France",
  ref_num: "PA604",
  party: "UMP",
  first_election?: true,
  hemicycle_seat: 413
)

representative2.save

puts "Creation d'une loi..."
law2 = Law.new(
  num: 3756,
  title: "Justice de la famille",
  description:"Proposition de loi, modifiée par le Sénat, obligeant une famille d'avoir un papa et une maman"
)
law2.representative = representative2
law2.save!

puts "Creation d'un utilisateur..."
user2 = User.new(
  email: Faker::Internet.email,
  password: "julien",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: "22 rue Galliéni",
  zip: "92100",
  city: "Boulogne Billancourt",
  age: 25,
)
 user2.representative = representative2
 user2.save!

 puts "Creation d'un vote d'un utilsateur..."
vote2 = UsersVote.new(
  voting_status: "for"
)

vote2.law = law2
vote2.user = user2
vote2.save!

puts "Creation d'un vote commentaire..."
comment2 = Comment.new(
  title: "Bonne idée.",
  content: "La loi va clairement dans le bon sens mais je ne penses pas ce que ca suffise aux jeunes.",
  voting_status: "for"
)
comment2.user = user2
comment2.law = law2
comment2.save!

puts "Creation d'un député..."
representative3 = Representative.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  salutation: ["M", "Mme"].sample,
  email: Faker::Internet.email,
  circonscription_ref: "PO584947",
  circonscription_num: 4,
  city: "Boulogne Billancourt",
  department: "Hauts de Seine",
  region: "Ile de France",
  ref_num: "PA489",
  party: "Parti Communiste",
  first_election?: false,
  hemicycle_seat: 483
)

representative3.save!

puts "Creation d'une loi..."
law3 = Law.new(
  num: 3903,
  title: "Justice des affaires",
  description:"Proposition de loi, pour avantager les riches et faire souffir les pauvres",
)
law3.representative = representative3
law3.save!

puts "Creation d'un utilisateur..."
user3 = User.new(
  email: Faker::Internet.email,
  password: "julien",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: "12 avenue Victor Hugo",
  zip: "75016",
  city: "Paris",
  age: 32,
)
 user3.representative = representative3
 user3.save!

 puts "Creation d'un vote d'un utilsateur..."
vote3 = UsersVote.new(
  voting_status: "against"
)

vote3.law = law3
vote3.user = user3
vote3.save!

puts "Creation d'un vote commentaire..."
comment3 = Comment.new(
  title: "Très mauvaise loi",
  content: "La loi n'a pas de sens dans le contexte dans lequel on est en ce moment!",
  voting_status: "against"
)
comment3.user = user3
comment3.law = law3
comment3.save!

puts "Creation d'un député..."
representative4 = Representative.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  salutation: ["M", "Mme"].sample,
  email: Faker::Internet.email,
  circonscription_ref: "PO729304",
  circonscription_num: 8,
  city: "Cabourg",
  department: "Calvados",
  region: "Haute Normandie",
  ref_num: "PA478",
  party: "Front National",
  first_election?: false,
  hemicycle_seat: 222
)

representative4.save!

puts "Creation d'une loi..."
law4 = Law.new(
  num: 3903,
  title: "Justice Social",
  description:"Proposition de loi, pour plus d'aide pour les jeunes au chomage.",
)
law4.representative = representative4
law4.save!

puts "Creation d'un utilisateur..."
user4 = User.new(
  email: Faker::Internet.email,
  password: "julien",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: "22 avenue sud du phare",
  zip: "92100",
  city: "Lege Cap-Ferret",
  age: 30,
)
 user4.representative = representative4
 user4.save!

 puts "Creation d'un vote d'un utilsateur..."
vote4 = UsersVote.new(
  voting_status: "against"
)

vote4.law = law4
vote4.user = user4
vote4.save!

puts "Creation d'un vote commentaire..."
comment4 = Comment.new(
  title: "Très décu par cette loi",
  content: "Il manque plein de chose dans cette loi, notamment l'aide aux jeunes qui n'ont pas réussi à trouver un job avant de toucher le chomage",
  voting_status: "against"
)
comment4.user = user4
comment4.law = law4
comment4.save!

puts "Creation d'un député..."
representative5 = Representative.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  salutation: ["M", "Mme"].sample,
  email: Faker::Internet.email,
  circonscription_ref: "PO345938",
  circonscription_num: 4,
  city: "5 rue de la paix",
  department: "Paris",
  region: "Ile de France",
  ref_num: "PA734",
  party: "Modem",
  first_election?: true,
  hemicycle_seat: 399
)

representative5 .save!
puts "Creation d'une loi..."
law5 = Law.new(
  num: 3903,
  title: "Justice Constitutionnelle",
  description:"Proposition de loi, pour changer la constitution à fin de créer une nouvelle République",
)
law5.representative = representative5
law5.save!

puts "Creation d'un utilisateur..."
user5 = User.new(
  email: Faker::Internet.email,
  password: "julien",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: "rue Casa Negre",
  zip: "97232",
  city: "Le Lamentin",
  age: 39,
)
 user5.representative = representative5
 user5.save!

 puts "Creation d'un vote d'un utilsateur..."
vote5 = UsersVote.new(
  voting_status: "for"
)

vote5.law = law5
vote5.user = user5
vote5.save!

puts "Creation d'un vote commentaire..."
comment5 = Comment.new(
  title: "Horriblement génial",
  content: "Ca fait 5 ans que j'attends ca, depuis que Mélanchon en a parlé à la présidentiel",
  voting_status: "for"
)
comment5.user = user5
comment5.law = law5
comment5.save!
