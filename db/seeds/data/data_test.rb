$test_data = {
  
  material_name: "DEBUG material",

  material_specifieds: ('material_spec001'..'material_spec010').to_a,
  
  kind_of_objects: [
    {"koo1": ('koos001'..'koos010').to_a},
    "koo2",
    {"koo3": [
      "S31",
      "S32",
      "S33"
    ]}
  ],
  production_techniques: [
    "annealing",
    "beating",
    "casting in a mould",
    "casting with lost wax technique",
    "cutting",
    "drawing",
    "forging",
    "hammering",
    "repoussé",
    "riveting",
    "smelting",
    "soldering",
    "undetermined",
  ],
  
  decorations: [
    "figurativ",
    "geometric",
    "relief"
  ],
  colors: [
    "beige",
    "black",
    "brown",
    "buff",
    "pink",
    "red"
  ], 
  decoration_colors: [
    "beige",
    "black",
    "blue",
    "brown",
    "buff",
    "grey",
    "green",
    "pink",
    "purple",
    "red",
    "white",
    "yellow"
  ], 
  decoration_techniques: [
    "applied",
    "burnished",
    "combed",
    "glazed",
    "impressed",
    "incised",
    "painted",
    "ribbed",
    "rouletted",
    "sgraffito",
    "slipped",
    "undetermined"
  ],
  preservation_materials: [
    "corroded",
    "sintered"
  ],
  preservation_objects: [
    "base",
    "body",
    "body-to-bottom",
    "complete",
    "complete profile",
    "foot",
    "fragment",
    "handle",
    "handle-to-body",
    "rim",
    "rim-to-body"
  ]
} # hash
