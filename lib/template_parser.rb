class TemplateParser
  attr_reader :template, :siege

  def self.parse(key, template)
    new(key, template).parse
  end

  def initialize(key, template)
    @template = template
    @siege = key.sieges.new
  end

  def parse
    attackers = template.delete("attackers") || []
    volleys = template.delete("volleys") || []
    @siege.assign_attributes(template)
    @siege.save!

    attackers.each { |attacker| parse_attacker(attacker) }
    volleys.each { |volley| parse_volley(volley) }
    puts "Siege Created: #{@siege.id}"
  end

  def parse_attacker(attacker)
    targets = attacker.delete("targets")
    attacker = @siege.attackers.create!(attacker)
    targets.each do |target|
      attacker.targets.create!(target.merge("siege_id" => @siege.id))
    end
  end

  def parse_volley(volley)
    @siege.volleys.create!(volley)
  end
end
