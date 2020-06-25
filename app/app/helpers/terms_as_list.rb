class TermsAsList
  attr_reader :terms_hash

  def initialize
    @terms_hash = {}
    @terms_hash[:materials] = Set.new
    @terms_hash[:material_specifieds] = Set.new
    @terms_hash[:kind_of_objects] = Set.new
    @terms_hash[:kind_of_object_specifieds] = Set.new
  end

  def deep_copy
    return Marshal.load(Marshal.dump(self))
  end

  def material_count
    @terms_hash[:materials].count
  end

  def material_specified_count
    @terms_hash[:material_specifieds].count
  end

  def kind_of_object_count
    @terms_hash[:kind_of_objects].count
  end

  def kind_of_object_specified_count
    @terms_hash[:kind_of_object_specifieds].count
  end

  def add_material_set m 
    @terms_hash[:materials] |= m
  end


  def add_material_specified_set ms
    @terms_hash[:material_specifieds] |= ms
  end


  def add_kind_of_object_set koo
    @terms_hash[:kind_of_objects] |= koo
  end


  def add_kind_of_object_specified_set koos
    @terms_hash[:kind_of_object_specifieds] |= koos
  end

  def material_direct_children
    term = @terms_hash[:materials].first
    return children(term)
  end

  def material_specified_direct_children
    term = @terms_hash[:material_specifieds].first
    return children(term)
  end

  def kind_of_object_direct_children
    term = @terms_hash[:kind_of_objects].first
    return children(term)
  end


  def kind_of_object_specified_direct_children
    term = @terms_hash[:kind_of_object_specifieds].first
    return children(term)
  end


  def material_transitive_children
    term = @terms_hash[:materials].first
    return transitive_children(term)
  end

  def material_specified_transitive_children
    term = @terms_hash[:material_specifieds].first
    return transitive_children(term)
  end

  def kind_of_object_transitive_children
    term = @terms_hash[:kind_of_objects].first
    return transitive_children(term)
  end

  def kind_of_object_specified_transitive_children
    term = @terms_hash[:kind_of_object_specifieds].first
    return transitive_children(term)
  end

  private
  def transitive_children term
    return term.paths.first.transitive_children.map(&:last_object)
  end

  def children term
    return term.paths.first.direct_children.map(&:last_object)
  end
end
