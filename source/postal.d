module postal;

import std.stdio;

struct PostalAddress {
	string house; /// venue name e.g. "Brooklyn Academy of Music", and building names e.g. "Empire State Building"
	string category; /// for category queries like "restaurants", etc.
	string near; /// phrases like "in", "near", etc. used after a category phrase to help with parsing queries like "restaurants in Brooklyn"
	string houseNumber; /// usually refers to the external (street-facing) building number. In some countries this may be a compount, hyphenated number which also includes an apartment number, or a block number (a la Japan), but libpostal will just call it the house_number for simplicity.
	string road; /// street name(s)
	string unit; /// an apartment, unit, office, lot, or other secondary unit designator
	string level; /// expressions indicating a floor number e.g. "3rd Floor", "Ground Floor", etc.
	string staircase; /// numbered/lettered staircase
	string entrance; /// numbered/lettered entrance
	string poBox; /// post office box: typically found in non-physical (mail-only) addresses
	string postcode; /// postal codes used for mail sorting
	string suburb; /// usually an unofficial neighborhood name like "Harlem", "South Bronx", or "Crown Heights"
	string cityDistrict; /// these are usually boroughs or districts within a city that serve some official purpose e.g. "Brooklyn" or "Hackney" or "Bratislava IV"
	string city; /// any human settlement including cities, towns, villages, hamlets, localities, etc.
	string island; /// named islands e.g. "Maui"
	string stateDistrict; /// usually a second-level administrative division or county.
	string state; /// a first-level administrative division. Scotland, Northern Ireland, Wales, and England in the UK are mapped to "state" as well (convention used in OSM, GeoPlanet, etc.)
	string countryRegion; /// informal subdivision of a country without any political status
	string country; /// sovereign nations and their dependent territories, anything with an ISO-3166 code.
	string worldRegion; /// currently only used for appending “West Indies” after the country name, a pattern frequently used in the English-speaking Caribbean e.g. “Jamaica, West Indies”
}

struct Postal {
@safe:
	import std.array : empty, front;
	import std.string : fromStringz, toStringz;
	import libpostal;
	static bool hasBeenInited;

	private static void checkInit() {
		if(!hasBeenInited) {
			bool initResult = () @trusted {
				return !libpostal_setup() || !libpostal_setup_parser();
			}();

			if(initResult) {
				throw new Exception("Failed to init libpostal");
			}
			hasBeenInited = true;
		}
	}	

	static PostalAddress parse(string input, string language = "", 
			string country = "") @trusted
	{
		import std.format : format;
		import std.conv : to;
		checkInit();
		libpostal_address_parser_options opts = libpostal_get_address_parser_default_options();
		if(!language.empty) {
			opts.language = cast(char*)language.toStringz();
		}
		if(!country.empty) {
			opts.country = cast(char*)country.toStringz();
		}

		libpostal_address_parser_response_t* parsed = libpostal_parse_address(
				cast(char*)input.toStringz(), opts);

		PostalAddress ret;

		for(size_t i = 0; i < parsed.num_components; i++) {
			string label = to!string(parsed.labels[i].fromStringz());
			string comp = to!string(parsed.components[i].fromStringz());
			switch(label) {
				case "house": ret.house = comp; break;
				case "category": ret.category = comp; break;
				case "near": ret.near = comp; break;
				case "house_number": ret.houseNumber = comp; break;
				case "roat": ret.road = comp; break;
				case "unit": ret.unit = comp; break;
				case "level": ret.level = comp; break;
				case "staircase": ret.staircase = comp; break;
				case "entrance": ret.entrance = comp; break;
				case "po_box": ret.poBox = comp; break;
				case "postcode": ret.postcode = comp; break;
				case "road": ret.road = comp; break;
				case "suburb": ret.suburb = comp; break;
				case "city_district": ret.cityDistrict = comp; break;
				case "city": ret.city = comp; break;
				case "island": ret.island = comp; break;
				case "state_district": ret.stateDistrict = comp; break;
				case "state": ret.state = comp; break;
				case "country_region": ret.countryRegion = comp; break;
				case "country": ret.country = comp; break;
				case "world_region": ret.worldRegion = comp; break;
				default:
					throw new Exception(format(
						"Unhandled address label '%s' with value '%s'", label,
						comp));

			}
		}

    	libpostal_address_parser_response_destroy(parsed);
		return ret;
	}
}

unittest {
	auto adr = Postal.parse("Quatre vingt douze Ave des Champs-Élysées, Paris,
			France", "French", "France");
	writeln(adr);
}

unittest {
	auto adr = Postal.parse("66-34 Eskdale Cl, Wembley, London");
	writeln(adr);
}
