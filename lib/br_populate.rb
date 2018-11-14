require 'json'

module BRPopulate
  def self.states
    JSON.parse(File.read('app/assets/config/states.json'))
  end

  def self.capital?(city, state)
    city.eql? state["capital"]
  end

  def self.populate_states_brazil
    ActiveRecord::Base.transaction do
      begin
        country = Country.find_by(name: "Brazil")
        states_json = BRPopulate.states
        states_json["states"].each do |state|
          s = State.new
          s.name = state["name"]
          s.short_name = state["short_name"]
          s.country = country
          s.save!

          state["cities"].each do |city|
            c = City.new
            c.name = city
            c.state = s
            c.capital = BRPopulate.capital?(city, state)
            c.save!
          end
        end
      rescue
        ActiveRecord::Rollback
      end
    end
  end
end