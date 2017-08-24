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
    attackers = template.delete("attackers")
    @siege.assign_attributes(template)
    @siege.save!

    attackers.each do |attacker|
      parse_attacker(attacker)
    end
    puts "Siege Created: #{@siege.id}"
  end

  def parse_attacker(attacker)
    targets = attacker.delete("targets")
    attacker = @siege.attackers.create!(attacker)
    targets.each do |target|
      attacker.targets.create!(target.merge("siege_id" => @siege.id))
    end
  end
end
