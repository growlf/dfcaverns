--dfcaverns.spawn_tower_cap_vm(vi, area, data)
--dfcaverns.spawn_fungiwood_vm(vi, area, data)
--dfcaverns.spawn_tunnel_tube_vm(vi, area, data, param2_data)
--dfcaverns.spawn_spore_tree_vm(vi, data, area)
--dfcaverns.spawn_goblin_cap_vm(vi, area, data)

local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_cobble = minetest.get_content_id("default:cobble")
local c_dirt = minetest.get_content_id("default:dirt")

local c_dirt_moss = minetest.get_content_id("dfcaverns:dirt_with_cave_moss")
local c_cobble_fungus = minetest.get_content_id("dfcaverns:cobble_with_floor_fungus")
local c_dead_fungus = minetest.get_content_id("dfcaverns:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("dfcaverns:cavern_fungi") -- param2 = 0

local subsea_level = (dfcaverns.config.level2_min - dfcaverns.config.level1_min) * 0.3 + dfcaverns.config.level2_min


local level_2_tower_cap_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_dirt_moss
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if math.random() < 0.1 then
		dfcaverns.place_shrub(data, vi, param2_data)
	elseif drip_rand < 0.1 then
		--subterrane:stalagmite(bi, area, data, 6, 15, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.005 then
		dfcaverns.spawn_tower_cap_vm(vi, area, data)
	end
end

local level_2_moist_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.075 then
		--subterrane:stalactite(ai, area, data, 6, 20, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.075 * 5)
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, -height, true)
	elseif math.random() < 0.03 then
		dfcaverns.glow_worm_ceiling(area, data, ai, vi, bi)
	end
end

local level_2_dry_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	if math.random() < 0.25 then
		data[bi] = c_cobble_fungus
		if math.random() < 0.1 then
			data[vi] = c_dead_fungus
		end
	elseif math.random() < 0.5 then
		data[bi] = c_cobble
	end	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)

	if drip_rand < 0.05 then
		--subterrane:stalagmite(bi, area, data, 6, 15, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.05 * 5)		
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, false)
	end
end

local level_2_wet_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end

	if math.random() < 0.25 then
		data[bi] = c_dirt_moss
		if math.random() < 0.1 then
			data[vi] = c_dead_fungus
		elseif math.random() < 0.1 then
			data[vi] = c_cavern_fungi
		end
	else
		data[bi] = c_dirt
	end	
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)

	if drip_rand < 0.05 then
		--subterrane:stalagmite(bi, area, data, 6, 15, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.05 * 5)		
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, true)
	end
end


local level_2_underwater_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	data[bi] = c_dirt
end

local level_2_dry_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.075 then
		--subterrane:stalactite(ai, area, data, 6, 20, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.075 * 5)
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, -height, false)
	end
end


local level_2_fungiwood_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_dirt_moss
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	
	if math.random() < 0.1 then
		dfcaverns.place_shrub(data, vi, param2_data)
	elseif drip_rand < 0.1 then
		--subterrane:stalagmite(bi, area, data, 6, 15, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.005 then
		dfcaverns.spawn_fungiwood_vm(vi, area, data)
	end
end

local level_2_tunnel_tube_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end

	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_dirt_moss
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	
	if math.random() < 0.1 then
		dfcaverns.place_shrub(data, vi, param2_data)
	elseif drip_rand < 0.1 then
		--subterrane:stalagmite(bi, area, data, 6, 15, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.05 then
		dfcaverns.spawn_tunnel_tube_vm(vi, area, data, param2_data)
	end
end

local level_2_spore_tree_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end

	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_dirt_moss
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	
	if math.random() < 0.1 then
		dfcaverns.place_shrub(data, vi, param2_data)
	elseif drip_rand < 0.1 then
		--subterrane:stalagmite(bi, area, data, 6, 15, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.05 then
		dfcaverns.spawn_spore_tree_vm(vi, area, data)
	end
end

local level_2_goblin_cap_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end

	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_dirt_moss
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	
	if math.random() < 0.1 then
		dfcaverns.place_shrub(data, vi, param2_data)
	elseif drip_rand < 0.1 then
		--subterrane:stalagmite(bi, area, data, 6, 15, c_stone, c_stone, c_stone)
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.025 then
		dfcaverns.spawn_goblin_cap_vm(vi, area, data)
	end
end

local level_2_cave_floor = function(area, data, ai, vi, bi, param2_data)
	if dfcaverns.can_support_vegetation[data[bi]] then
		data[bi] = c_dirt_moss
		if math.random() < 0.25 then
			if data[vi] == c_air then
				dfcaverns.place_shrub(data, vi, param2_data)
			end
		end
		return
	end
	
	if data[bi] == c_cobble and math.random() < 0.001 then
		data[bi] = c_cobble_fungus
		return
	end
	
	if data[bi] ~= c_stone then
		return
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.075 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.075 * 4)
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, true)
	end	
end

local level_2_cave_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)

	if drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, -height, true)
	end	
end

-------------------------------------------------------------------------------------------


minetest.register_biome({
	name = "dfcaverns_level2_flooded_biome_lower",
	y_min = dfcaverns.config.level2_min,
	y_max = subsea_level,
	heat_point = 20,
	humidity_point = 0,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_water,
	_subterrane_floor_decor = level_2_underwater_floor,
	_subterrane_mitigate_lava = false,
})

minetest.register_biome({
	name = "dfcaverns_level2_flooded_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level1_min,
	heat_point = 20,
	humidity_point = 0,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_wet_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_fill_node = c_water,
	_subterrane_mitigate_lava = true,
})


minetest.register_biome({
	name = "dfcaverns_level2_tower_cap_biome_lower",
	y_min = dfcaverns.config.level2_min,
	y_max = subsea_level,
	heat_point = 40,
	humidity_point = 10,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_tower_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_tower_cap_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level1_min,
	heat_point = 40,
	humidity_point = 10,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_tower_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_fungiwood_biome_lower",
	y_min = dfcaverns.config.level2_min,
	y_max = subsea_level,
	heat_point = 80,
	humidity_point = 50,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_fungiwood_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_fungiwood_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level1_min,
	heat_point = 80,
	humidity_point = 50,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_fungiwood_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_goblin_cap_biome_lower",
	y_min = dfcaverns.config.level2_min,
	y_max = subsea_level,
	heat_point = 60,
	humidity_point = 20,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_goblin_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_goblin_cap_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level1_min,
	heat_point = 60,
	humidity_point = 20,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_goblin_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})


minetest.register_biome({
	name = "dfcaverns_level2_spore_tree_biome_lower",
	y_min = dfcaverns.config.level2_min,
	y_max = subsea_level,
	heat_point = 60,
	humidity_point = 80,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_spore_tree_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_spore_tree_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level1_min,
	heat_point = 60,
	humidity_point = 80,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_spore_tree_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_tunnel_tube_biome_lower",
	y_min = dfcaverns.config.level2_min,
	y_max = subsea_level,
	heat_point = 40,
	humidity_point = 100,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_tunnel_tube_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_tunnel_tube_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level1_min,
	heat_point = 40,
	humidity_point = 100,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_tunnel_tube_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_dry_biome_lower",
	y_min = dfcaverns.config.level2_min,
	y_max = subsea_level,
	heat_point = 20,
	humidity_point = 110,
	_subterrane_ceiling_decor = level_2_dry_ceiling,
	_subterrane_floor_decor = level_2_dry_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = false,
})

minetest.register_biome({
	name = "dfcaverns_level2_dry_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level1_min,
	heat_point = 20,
	humidity_point = 110,
	_subterrane_ceiling_decor = level_2_dry_ceiling,
	_subterrane_floor_decor = level_2_dry_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = false,
})