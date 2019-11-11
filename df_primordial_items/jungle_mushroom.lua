-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

------------------------------------------------------------------------------------------
-- Big jungle mushroom

minetest.register_node("df_primordial_items:jungle_mushroom_trunk", {
	description = S("Primordial Jungle Mushroom Trunk"),
	_doc_items_longdesc = df_primordial_items.doc.big_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.big_mushroom_usage,
	tiles = {"dfcaverns_jungle_mushroom_stem.png", "dfcaverns_jungle_mushroom_stem.png", "dfcaverns_jungle_mushroom_stem_02.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("df_primordial_items:jungle_mushroom_cap_1", {
	description = S("Pale Jungle Mushroom Cap"),
	_doc_items_longdesc = df_primordial_items.doc.big_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.big_mushroom_usage,
	tiles = {"dfcaverns_jungle_mushroom_top_02.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	drop = {
		max_items = 1,
		items = {
			{
				items = {"df_primordial_items:jungle_mushroom_sapling"},
				rarity = 10,
			},
			{
				items = {"df_primordial_items:jungle_mushroom_cap_1"},
			}
		}
	},
})

minetest.register_node("df_primordial_items:jungle_mushroom_cap_2", {
	description = S("Dark Jungle Mushroom Cap"),
	_doc_items_longdesc = df_primordial_items.doc.big_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.big_mushroom_usage,
	tiles = {"dfcaverns_jungle_mushroom_top_01.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	drop = {
		max_items = 1,
		items = {
			{
				items = {"df_primordial_items:jungle_mushroom_sapling"},
				rarity = 10,
			},
			{
				items = {"df_primordial_items:jungle_mushroom_cap_2"},
			}
		}
	},
})

minetest.register_craftitem("df_primordial_items:diced_mushroom", {
	description = S("Diced Mushroom"),
	_doc_items_longdesc = df_primordial_items.doc.big_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.big_mushroom_usage,
	inventory_image = "dfcaverns_mush_diced_giant_mushroom.png",
	groups = {food = 1, dfcaverns_cookable = 1},
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	output = "df_primordial_items:diced_mushroom 4",
	type = "shapeless",
	recipe = { "df_primordial_items:jungle_mushroom_cap_1"},
})
minetest.register_craft({
	output = "df_primordial_items:diced_mushroom 4",
	type = "shapeless",
	recipe = { "df_primordial_items:jungle_mushroom_cap_2"},
})


minetest.register_node("df_primordial_items:jungle_mushroom_sapling", {
	description = S("Primordial Jungle Mushroom Sapling"),
	_doc_items_longdesc = df_primordial_items.doc.big_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.big_mushroom_usage,
	tiles = {"dfcaverns_jungle_mushroom_02.png^[brighten"},
	inventory_image = "dfcaverns_jungle_mushroom_02.png^[brighten",
	wield_image = "dfcaverns_jungle_mushroom_02.png^[brighten",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	is_ground_content = false,
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(
			math.random(
				df_trees.config.nether_cap_delay_multiplier*df_trees.config.tree_min_growth_delay,
				df_trees.config.nether_cap_delay_multiplier*df_trees.config.tree_max_growth_delay)
		)
	end,
	
	on_timer = function(pos)
		minetest.set_node(pos, {name="air"})
		df_primordial_items.spawn_jungle_mushroom(pos)
	end,
})

local c_stem = minetest.get_content_id("df_primordial_items:jungle_mushroom_trunk")
local c_cap_1 = minetest.get_content_id("df_primordial_items:jungle_mushroom_cap_1")
local c_cap_2 = minetest.get_content_id("df_primordial_items:jungle_mushroom_cap_2")
local c_air = minetest.get_content_id("air")

df_primordial_items.spawn_jungle_mushroom = function(pos)
	local x, y, z = pos.x, pos.y, pos.z
	local stem_height = math.random(1,3)
	local cap_radius = math.random(2,3)
	local maxy = y + stem_height + 3
	
	local c_cap
	if math.random() > 0.5 then
		c_cap = c_cap_1
	else
		c_cap = c_cap_2
	end
	
	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = x - cap_radius, y = y, z = z - cap_radius},
		{x = x + cap_radius, y = maxy + 3, z = z + cap_radius}
	)
	local area = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	subterrane.giant_mushroom(area:indexp(pos), area, data, c_stem, c_cap, c_air, stem_height, cap_radius)
	
	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
end

df_primordial_items.spawn_jungle_mushroom_vm = function(vi, area, data)
	local stem_height = math.random(1,3)
	local cap_radius = math.random(2,3)
	local c_cap
	if math.random() > 0.5 then
		c_cap = c_cap_1
	else
		c_cap = c_cap_2
	end
	subterrane.giant_mushroom(vi, area, data, c_stem, c_cap, c_air, stem_height, cap_radius)
end