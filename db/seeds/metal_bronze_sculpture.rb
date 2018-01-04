id = ENV.fetch("id")

sculpture = TermlistKindOfObject.where(name: "sculpture")
                              .where(termlist_material_specified: TermlistMaterialSpecified
                                .where(id: id))
                              .first

statuette = TermlistKindOfObjectSpecified.create name: "statuette"              
sculpture.termlist_kind_of_object_specifieds << statuette
