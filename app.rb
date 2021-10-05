require 'colorize'
require 'linguistics'
Linguistics.use :en

system ('clear')
puts "┌─────────────────────────────────────────┐"
puts "│ On va créer une relation N-N dans rails │"
puts "└─────────────────────────────────────────┘"
puts
puts "Quel est le nom de ta première table ?"
print "> "
table1 = gets.chomp.to_s
puts "$ " + "rails g model ".yellow + table1.yellow
puts

puts "Quel est le nom de ta deuxième table ?"
print "> "
table2 = gets.chomp.to_s
puts "$ " + "rails g model ".yellow + table2.yellow
puts

default = "JoinTable".yellow + "#{table1.en.plural}".blue + "#{table2}".green
default_no_color = "JoinTable" + "#{table1.en.plural}" + "#{table2}"

puts "Quel est le nom de ta table intermédiaire ? " + default + " par défaut."
# IO.popen('pbcopy', 'w') { |pipe| pipe.puts default_no_color}

print "> "
table_i = gets.chomp.to_s
puts "$ " + "rails g model ".yellow + table_i.yellow
puts


arrow1 = " M -----> 1 "
arrow2 = " 1 <----- M "

puts "┌".red + "─".red*(table1.size + 2) + "┐".red + " "*(arrow1.size) + "┌".red + "─".red*(table_i.size + 2) + "┐".red + " "*(arrow2.size) + "┌".red + "─".red*(table2.size + 2) + "┐".red
puts "│ ".red + table1.red + " │".red + arrow1 + "│ ".red + table_i.red + " │".red + arrow2 + "│ ".red + table2.red + " │".red
puts "└".red + "─".red*(table1.size + 2) + "┘".red + " "*(arrow1.size) + "└".red + "─".red*(table_i.size + 2) + "┘".red + " "*(arrow2.size) + "└".red + "─".red*(table2.size + 2) + "┘".red

#MIGRATION FILE NAME#################
array = table_i.split /(?=[A-Z])/
size = array.size 
last = array.last
result = []
(size-1).times do |i|
	new_word = array[i].downcase+"_"
	result << new_word
end
result << last.downcase.en.plural
answer = result.join('')
#####################################

#MODEL FILE NAME#####################
array = table_i.split /(?=[A-Z])/
size = array.size 
last = array.last
result = []
(size-1).times do |i|
	new_word = array[i].downcase+"_"
	result << new_word
end
result << last.downcase
answer2 = result.join('')
#####################################

line = "★ ☆ ★ ☆ ★ ☆ ★ ☆ ★ ☆ ★ ☆ ★ ☆ ★ ☆ ★ ☆ ★ ☆ ★ ☆ ★ ☆ ★"

puts "Si tout est OK, appuie sur entrer."
gets
system ('clear')
puts line
puts
puts "Dans ton fichier de " + "MIGRATION ".red + "XXXXXXXX_create_#{answer}.rb".cyan + " (dans db/migrate)" + ", ajoute ceci:"
puts
puts "t." + "belongs_to".green + " :#{table1.downcase}, index: true".blue
puts "t." + "belongs_to".green + " :#{table2.downcase}, index: true".blue
puts
puts line
puts
puts "Dans ton fichier " + "MODEL ".red + "#{answer2}.rb".cyan + " (dans app/models)" + ", ajoute ceci:"
puts "Vérifie bien que cette migration est " +"down".red + "."
puts
puts "belongs_to" + " :#{table1.downcase}".blue
puts "belongs_to" + " :#{table2.downcase}".blue
puts
puts line
puts
puts "Dans ton fichier " + "MODEL ".red + "#{table1.downcase}.rb".cyan + " (dans app/models)" + ", ajoute ceci:"
puts
puts "has_many" + " :#{answer}".blue
puts "has_many" + " :#{table2.downcase.en.plural}, through: :#{answer}".blue
puts
puts line
puts
puts "Dans ton fichier " + "MODEL ".red + "#{table2.downcase}.rb".cyan + " (dans app/models)" + ", ajoute ceci:"
puts
puts "has_many" + " :#{answer}".blue
puts "has_many" + " :#{table1.downcase.en.plural}, through: :#{answer}".blue
puts
puts line
puts
puts "Un petit " + "rails db:migrate".green + " et tout est bon."
puts
puts line
puts