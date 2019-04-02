# Note that we do a little bit of pre-optimization by avoiding to
# hit the database too often and work with ids instead of the actual objects

@storage_ids = Storage.all.ids
@storage_location_ids = StorageLocation.all.ids
@termlist_acquisition_ids = TermlistAcquisitionKind.all.ids
@termlist_acquisition_delivered_by_ids = TermlistAcquisitionDeliveredBy.all.ids
@termlist_excavation_site_kind_ids = TermlistExcavationSiteKind.all.ids
@termlist_material_specified_ids = TermlistMaterialSpecified.all.ids
@termlist_kind_of_object_ids = TermlistKindOfObject.all.ids


@deliverer_names = [
                    "Robert Lewandowski",
                    "Mario Götze",
                    "Xherdan Shaqiri",
                    "Mario Mandžukić",
                    "Javi Martínez",
                    "Luiz Gustavo",
                    "Jérôme Boateng",
                    "Manuel Neuer",
                    "Diego Contento",
                    "David Alaba",
                    "Holger Badstuber",
                    "Mario Gómez",
                    "Anatoliy Tymoshchuk",
                    "Ivica Olić",
                    "Danijel Pranjić",
                    "Arjen Robben",
                    "Thomas Müller",
                    "Toni Kroos "
                   ]
@rand_location = [
                    "Zürich",
                    "Bern",
                    "Luzern",
                    "Uri",
                    "Schwyz",
                    "Obwalden",
                    "Nidwalden",
                    "Glarus",
                    "Zug",
                    "Freiburg",
                    "Solothurn",
                    "Basel-Stadt",
                    "Basel-Landschaft",
                    "Schaffhausen",
                    "Appenzell Ausserrhoden",
                    "Appenzell Innerrhoden",
                    "St. Gallen",
                    "Graubünden", 
                    "Aargau", 
                    "hurgau",
                    "Tessin",
                    "Waadt",
                    "Wallis",
                    "Neuenburg",
                    "Genf",
                    "Jura"
                   ]
@rand_texts = ["Am finished rejoiced drawings so he elegance. Set lose dear upon had two its what seen. Held she sir how know what such whom. Esteem put uneasy set piqued son depend her others. Two dear held mrs feet view her old fine. Bore can led than how has rank. Discovery any extensive has commanded direction. Short at front which blind as. Ye as procuring unwilling principle by.",
"Ye on properly handsome returned throwing am no whatever. In without wishing he of picture no exposed talking minutes. Curiosity continual belonging offending so explained it exquisite. Do remember to followed yourself material mr recurred carriage. High drew west we no or at john. About or given on witty event. Or sociable up material bachelor bringing landlord confined. Busy so many in hung easy find well up. So of exquisite my an explained remainder. Dashwood denoting securing be on perceive my laughing so.",
"He moonlight difficult engrossed an it sportsmen. Interested has all devonshire difficulty assistance joy. Unaffected at ye of compliment alteration to. Place voice no arise along to. Parlors waiting so against me no. Wishing calling are warrant settled was luckily. Express besides it present if at an opinion visitor. ",
"Perhaps far exposed age effects. Now distrusts you her delivered applauded affection out sincerity. As tolerably recommend shameless unfeeling he objection consisted. She although cheerful perceive screened throwing met not eat distance. Viewing hastily or written dearest elderly up weather it as. So direction so sweetness or extremity at daughters. Provided put unpacked now but bringing.",
"Up am intention on dependent questions oh elsewhere september. No betrayed pleasure possible jointure we in throwing. And can event rapid any shall woman green. Hope they dear who its bred. Smiling nothing affixed he carried it clothes calling he no. Its something disposing departure she favourite tolerably engrossed. Truth short folly court why she their balls. Excellence put unaffected reasonable mrs introduced conviction she. Nay particular delightful but unpleasant for uncommonly who.",
"By in no ecstatic wondered disposal my speaking. Direct wholly valley or uneasy it at really. Sir wish like said dull and need make. Sportsman one bed departure rapturous situation disposing his. Off say yet ample ten ought hence. Depending in newspaper an september do existence strangers. Total great saw water had mirth happy new. Projecting pianoforte no of partiality is on. Nay besides joy society him totally six.",
"You vexed shy mirth now noise. Talked him people valley add use her depend letter. Allowance too applauded now way something recommend. Mrs age men and trees jokes fancy. Pretended engrossed eagerness continued ten. Admitting day him contained unfeeling attention mrs out.",
"Denote simple fat denied add worthy little use. As some he so high down am week. Conduct esteems by cottage to pasture we winding. On assistance he cultivated considered frequently. Person how having tended direct own day man. Saw sufficient indulgence one own you inquietude sympathize.",
"An an valley indeed so no wonder future nature vanity. Debating all she mistaken indulged believed provided declared. He many kept on draw lain song as same. Whether at dearest certain spirits is entered in to. Rich fine bred real use too many good. She compliment unaffected expression favourable any. Unknown chiefly showing to conduct no. Hung as love evil able to post at as.",
"Concerns greatest margaret him absolute entrance nay. Door neat week do find past he. Be no surprise he honoured indulged. Unpacked endeavor six steepest had husbands her. Painted no or affixed it so civilly. Exposed neither pressed so cottage as proceed at offices. Nay they gone sir game four. Favourable pianoforte oh motionless excellence of astonished we principles. Warrant present garrets limited cordial in inquiry to. Supported me sweetness behaviour shameless excellent so arranging."
]

@rand_short_texts = ["Am finished rejoiced drawings so he elegance.",
"Do remember to followed yourself material mr recurred carriage.",
"He moonlight difficult engrossed an it sportsmen.",
"Perhaps far exposed age effects.",
"Up am intention on dependent questions oh elsewhere september. No betrayed pleasure possible jointure we in throwing.",
"By in no ecstatic wondered disposal my speaking.",
"You vexed shy mirth now noise.",
"Denote simple fat denied add worthy little use.",
"An an valley indeed so no wonder future nature vanity.",
"Concerns greatest margaret him absolute entrance nay."
]


def rand_delivered_by_id
  @termlist_acquisition_delivered_by_ids.sample
end

def rand_deliverer_name
  @deliverer_names.sample
end

def rand_char
  ('A'..'Z').to_a.sample
end

def rand_number min, max
  (min..max).to_a.sample
end

def rand_storage_id
  @storage_ids.sample
end

def rand_storage_location_id storage_id
  storage = Storage.find storage_id
  storage.storage_locations.ids.sample
end

def rand_storage_location_id
  @storage_location_ids.sample
end

def rand_inv_number prefix
 prefix + "." + rand(100..10000).to_s
end

def rand_other_inv_number
  rand_char + "." + rand_char + rand(100..10000).to_s
end

def rand_date
  rand(Date.civil(1900, 1, 1)..Date.today)
end

def rand_boolean
  [true, false].sample
end

def rand_coordinates
  rand(10).to_s + "." + rand(100000).to_s + " " + rand(10).to_s + "." + rand(100000).to_s
end

def rand_excavation_site_id
  @termlist_excavation_site_kind_ids.sample
end

def rand_text
  @rand_texts.sample
end

def rand_short_text
  @rand_short_texts.sample
end

def rand_material_specified_id
  @termlist_material_specified_ids.sample
end

def rand_kind_of_object_id material_specified
  #@termlist_kind_of_object_ids.sample
  material_specified.termlist_kind_of_objects.ids.sample
end

def rand_kind_of_object_specified_id kind_of_object
  kind_of_object.termlist_kind_of_object_specifieds.ids.sample
end

def rand_color_id kind_of_object_specified
  kind_of_object_specified.termlist_colors.ids.sample
end

# Testing with millions of records is on the roadmap so we
# choose a way that allows us to create many records fast by writing
# associations manually into the database instead of doing millions of
# rails calls by using <<.
# For this we need the id of the object beforehand, so we start by creating
# the object.
museum_object = MuseumObject.new
museum_object.save validate: false
museum_object.inv_number = rand_inv_number "J"
museum_object.inv_numberdoa = rand_other_inv_number
museum_object.storage_location = StorageLocation.find rand_storage_location_id
museum_object.inv_extension = rand(15)
museum_object.amount = rand(10)
museum_object.acquisition_deliverer_name = rand_deliverer_name
museum_object.termlist_acquisition_delivered_by = TermlistAcquisitionDeliveredBy.find rand_delivered_by_id
museum_object.acquisition_date = rand_date
museum_object.is_acquisition_date_exact = rand_boolean
museum_object.site_number_mega = rand_number 1000, 10000
museum_object.site_number_jadis = rand_number 1000, 10000
museum_object.site_number_expedition = rand_number 1000, 10000
museum_object.name_mega_jordan = @rand_location.sample
museum_object.name_expedition = @rand_location.sample
museum_object.coordinates_mega = rand_coordinates
museum_object.termlist_excavation_site_kind = TermlistExcavationSiteKind.find rand_excavation_site_id
museum_object.finding_context = rand_short_text
museum_object.finding_remarks = rand_text
rand_material = TermlistMaterialSpecified.find rand_material_specified_id
museum_object.termlist_material_specifieds << rand_material
rand_koo = TermlistKindOfObject.find rand_kind_of_object_id rand_material
museum_object.termlist_kind_of_object = rand_koo
rand_koos = TermlistKindOfObjectSpecified.find rand_kind_of_object_specified_id(rand_koo)
museum_object.termlist_kind_of_object_specified = rand_koos
museum_object.termlist_color = TermlistColor.find rand_color_id(rand_koos)

