ceramic = TermlistMaterial.where(name: "ceramic").first

ceramic_material_specifieds = [
  "African Red Slip Ware (ARSW)", 
  "Cypriote Base-Ring-Ware",
  "Chocolate-on-White Ware",
  "Cypriote Red Slip Ware (CRSW)",
  "Eastern Terra Sigillata (ETS)",
  "Khirbet Kerak Ware",
  "Late Helladic (LH)",
  "Late Roman Coarse Ware (LRCW)",
  "Metal Ware",
  "porcelain",
  "pseudo-celadon",
  "Terra Sigillata (TS)",
  "White Slip Ware",
  "undetermined"]

ceramic_kind_of_objects = [
  {"architectural element": 
    ["floor tile", 
     "roof tile", 
     "water pipe"]},
  "coffin",
  "coffin lid",
  "inscribed tablet",
  "knob",
  "lid",
  "ostracon",
  "sarcophagus",
  {"sculpture": 
    ["bust", 
     "figurine anthropomorphic",
     "figurine anthropomorphic-theriomorphic",
     "figurine theriomorphic",
     "mask"]},
  "spindle whorl",
  "spoon",
  {"vessel":
    ["alabastron",
     "amphora",
    "amphoriskos",
    "anthropomorphic vessel",
    "basin",
    "bottle",
    "bowl",
    "casserole",
    "chalice",
    "churn",
    "cooking pot",
    "cornet",
    "cup",
    "dish",
    "fenestrated-pedestalled bowl",
    "fish plate",
    "flask",
    "goblet",
    "holemouth vessel",
    "jar",
    "jug",
    "kernos",
    "krater",
    "lagynos",
    "lamp",   
    "pithos",
    "plate",
    "platter",
    "pyxis",
    "rhyton",
    "spouted jar",
    "stand",
    "storage jar",
    "strainer",
    "sugar bowl",
    "table amphora",
    "theomorphic vessel",
    "twin-amphoriskos",
    "twin-cup",
    "unguentarium"]}
  ]

ceramic_material_specifieds.each do |material_specified|
  m = TermlistMaterialSpecified.create name: material_specified
  ceramic_kind_of_objects.each do |kind_of_object|
    if kind_ob_object.class == Hash
    # ToDo: Implement
    end
    m << k
  end
  ceramic.termlist_material_specifieds << m
end
