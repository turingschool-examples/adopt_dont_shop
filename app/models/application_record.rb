class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(search_params)
    where("name ILIKE ?", "%#{search_params}%")
  end

  def self.unformatted_attributes
    attrs = attribute_names

    unfrozen_attrs = []
    attrs.each do |attr|
      unfrozen_attrs << attr.dup
    end
    unfrozen_attrs
  end

  def self.formatted_attributes
    attrs = attribute_names

    unfrozen_attrs = []
    attrs.each do |attr|
      unfrozen_attrs << attr.dup
    end

    formatted_hash = {}

    unfrozen_attrs.each do |ufattr|
      formatted_hash[ufattr] = ufattr.gsub('_',' ').split.map do |word|
                                                      if word != 'id'
                                                        word.capitalize
                                                      else
                                                            word.upcase
                                                      end
                                                    end.join(' ')
      end
      formatted_hash.delete('created_at')
      formatted_hash.delete('updated_at')
      formatted_hash


    #delete keys here
    # attrs_no_timestamps = unfrozen_attrq
  # s.find_all do |ufattr|
    #     ufattr != 'Created At' && ufattr != 'Updated At'
    # end
    # require 'pry'; binding.pry
  end
end
