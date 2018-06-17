$fn = 24;

global_width = 250;
global_height =110; 
global_corner_radius = 3;
global_screwhole_distance_from_edge = 5;
global_screwhole_diameter = 3;
global_screwhole_tolerence = 0.3;
global_switch_columns = 12;
global_switch_rows = 4;
global_switch_width = 14;
global_switch_height = 14;
global_switch_horizontal_spacing = 5.05;
global_switch_vertical_spacing = 5.05;
global_switchholes_x = 13.225;
global_switchholes_y = 13.225;
global_border_thickness = 10;

color("blue")
	plate();
translate([0, 0, 5])
	color("red")
		border();

module border()
{
	difference()
	{
		case();
		primary_screwholes();
		translate([global_border_thickness, global_border_thickness])
			square([global_width - (global_border_thickness * 2), global_height - (global_border_thickness * 2)]);
	}
}

module plate()
{
	difference()
	{
		case();
		primary_screwholes();
		switchholes();
	}
}

module case()
{
	union()
	{
		difference()
		{
			square([global_width, global_height]);
			translate([0, 0])
				square([global_corner_radius, global_corner_radius]);
			translate([global_width - global_corner_radius, 0])
				square([global_corner_radius, global_corner_radius]);
			translate([0, global_height - global_corner_radius])
				square([global_corner_radius, global_corner_radius]);
			translate([global_width - global_corner_radius, global_height - global_corner_radius])
				square([global_corner_radius, global_corner_radius]);
		}
		translate([global_corner_radius, global_corner_radius])
			circle(global_corner_radius);
		translate([global_width - global_corner_radius, global_corner_radius])
			circle(global_corner_radius);
		translate([global_corner_radius, global_height - global_corner_radius])
			circle(global_corner_radius);
		translate([global_width - global_corner_radius, global_height - global_corner_radius])
			circle(global_corner_radius);
	}
}

module primary_screwholes()
{
	translate([global_screwhole_distance_from_edge, global_screwhole_distance_from_edge])
		circle((global_screwhole_diameter / 2) + global_screwhole_tolerence);
	translate([global_width - global_screwhole_distance_from_edge, global_screwhole_distance_from_edge])
		circle((global_screwhole_diameter / 2) + global_screwhole_tolerence);
	translate([global_screwhole_distance_from_edge, global_height - global_screwhole_distance_from_edge])
		circle((global_screwhole_diameter / 2) + global_screwhole_tolerence);
	translate([global_width - global_screwhole_distance_from_edge, global_height - global_screwhole_distance_from_edge])
		circle((global_screwhole_diameter / 2) + global_screwhole_tolerence);
}

module switchholes()
{
	translate([global_switchholes_x, global_switchholes_y])
	{
		for (x = [0:global_switch_columns - 1])
		{
			for (y = [0:global_switch_rows - 1])
			{
				translate([x * (global_switch_width + global_switch_horizontal_spacing), y * (global_switch_height + global_switch_vertical_spacing)])
					square([global_switch_width, global_switch_height]);
			}
		}
	}
}