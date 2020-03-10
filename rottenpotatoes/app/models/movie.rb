class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  
  def self.movies_related id, options
    key_hash = options.select { |key,value| value != nil and value != '' }

    if key_hash.keys.length == 0
      return []
    end

    build_hash = all()
    key_hash.each do |key, val|
      build_hash = build_hash.where("%s = '%s'" % [key, val])
    end
    build_hash = build_hash.where("id != '%s'" % [id])
    return build_hash
  end
  
end
