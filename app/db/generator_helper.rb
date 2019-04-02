def rand_inv_number prefix = nil
  if prefix.blank?
    "J." + rand(100..10000).to_s
  else 
    prefix + "." + rand(100..10000).to_s
  end
end

def rand_other_inv_number
  rand_char + "." + rand_char + rand(100..10000).to_s
end

def rand_kind_of_object material_specified
  TermlistKindOfObject.find material_specified.termlist_kind_of_objects.ids.sample
end

def rand_kind_of_object_specified kind_of_object
  TermlistKindOfObjectSpecified.find kind_of_object.termlist_kind_of_object_specifieds.ids.sample
end


# Model-independent random methods

def rand_number min, max
  (min..max).to_a.sample
end

def rand_date
  rand(Date.civil(1900, 1, 1)..Date.today)
end

def rand_char
  ('A'..'Z').to_a.sample
end

def rand_coordinates
  rand(10).to_s + "." + rand(1000000).to_s + " " + rand(10).to_s + "." + rand(1000000).to_s
end
