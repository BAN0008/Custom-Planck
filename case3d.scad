$fn = 12;

gd = 6;

module usb_cutout(cx, ty, w, h)
{
    translate([cx - (w / 2), ty - h, 0])
        cube([w, h, gd]);
}

module switch_holes(c, r)
{
	for (i = [0 : c-1])
	{
		for (j = [0 : r-1])
		{
			translate([i * 19.05, j * 19.05, 0])
				cube([14, 14, gd]);
		}
	}
}

module screw(d = 3, t = 0.15)
{
	cylinder(h=gd, r=((d / 2) + t));
}

module screws(w, h)
{
	translate([5, 5, 0])
		screw();
	translate([w - 5, 5, 0])
		screw();
	translate([5, h - 5, 0])
		screw();
	translate([w - 5, h - 5, 0])
		screw();
	translate([(w / 2) - 15, h - 5, 0])
		screw();
	translate([(w / 2) + 15, h - 5, 0])
		screw();
}

module case(r = 3, w = 250, h = 110)
{
	difference()
	{
		union()
		{
			difference()
			{
				cube([w, h, gd]);
				if (r != 0)
				{
					translate([0, 0, 0])
						cube([r, r, gd]);
					translate([w - r, 0])
						cube([r, r, gd]);
					translate([0, h - r, 0])
						cube([r, r, gd]);
					translate([w - r, h - r, 0])
						cube([r, r, gd]);
				}
			}
			if (r != 0)
			{
				translate([r, r, 0])
					cylinder(h=gd, r=r);
				translate([w - r, r, 0])
					cylinder(h=gd, r=r);
				translate([r, h - r, 0])
					cylinder(h=gd, r=r);
				translate([w - r, h - r, 0])
					cylinder(h=gd, r=r);
			}
		}
		screws(w, h);
	}
}

module open()
{
	difference()
	{
		case(3);
		translate([10, 10, 0])
			cube([230, 90, gd]);
		usb_cutout(250 / 2, 110, 20, 10);
	}
}

module closed()
{
	difference()
	{
		case(3);
		translate([10, 10, 0])
			cube([230, 90, gd]);
	}
}

module bottom()
{
	case(3);
}

module top()
{
	difference()
	{
		case(3);
		translate([10, 10, 0])
			cube([250 - 20, 110 - 30, gd]);
	}
}

module switch_plate()
{
	difference()
	{
		case(3);
		translate([13.225, 13.225, 0])
			switch_holes(12, 4);
	}
}

translate([0, 0, 0]);
    bottom();
translate([0, 0, gd])
    closed();
translate([0, 0, gd * 2])
    open();
translate([0, 0, gd * 3])
    switch_plate();
translate([0, 0, gd * 4])
    top();
//switch_plate();
//open();
//top();
//bottom();
//closed();