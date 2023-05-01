require 'csv'
require 'securerandom'

class Gossip
  attr_accessor :id, :author, :content

  def initialize(author, content, id = SecureRandom.uuid)
    @id = id
    @author = author
    @content = content
  end

  def self.all
    all_gossips = []
    CSV.foreach("./db/gossip.csv") do |row|
      gossip = Gossip.new(row[1], row[2], row[0])
      all_gossips << gossip
    end
    all_gossips
  end

  def self.find(id)
    CSV.foreach("./db/gossip.csv") do |row|
      if row[0] == id
        gossip = Gossip.new(row[1], row[2], row[0])
        return gossip
      end
    end
    puts "No gossip found with this id"
    return nil
  end

  def save
    CSV.open("./db/gossip.csv", 'a+') do |csv|
      csv << [SecureRandom.uuid, author, content]
      puts "Gossip saved!"
    end
    puts 'Status 200 - OK'
  end
end
