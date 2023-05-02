require 'csv'
require 'securerandom'

class Gossip
  attr_accessor :id, :author, :content

  def initialize(id = SecureRandom.uuid, author, content)
    @id = id
    @author = author
    @content = content
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      gossip = Gossip.new(csv_line[0], csv_line[1], csv_line[2])
      pp gossip
      all_gossips << gossip
      pp all_gossips
    end
    return all_gossips
  end

  def self.find(id)
    all_gossips = self.all
    pp all_gossips
    return all_gossips[id.to_i]
    pp all_gossips
  end

  def self.edit(id, content)

  end

  def save
    CSV.open("./db/gossip.csv", 'a+') do |csv|
      csv << [SecureRandom.uuid, author, content]
      puts "Gossip saved!"
    end
    puts 'Status 200 - OK'
  end
end
