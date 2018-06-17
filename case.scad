$fn = 256;

module usb_cutout(cx, ty, w, h)
{
    translate([cx - (w / 2), ty - h])
        square([w, h]);
}

module switch_holes(c, r)
{
	for (i = [0 : c-1])
	{
		for (j = [0 : r-1])
		{
			translate([i * 19.05, j * 19.05])
				square([14, 14]);
		}
	}
}

module screw(d = 3, t = 0.15)
{
	circle((d / 2) + t);
}

module screws(w, h)
{
	translate([5, 5])
		screw();
	translate([w - 5, 5])
		screw();
	translate([5, h - 5])
		screw();
	translate([w - 5, h - 5])
		screw();
	translate([(w / 2) - 15, h - 5])
		screw();
	translate([(w / 2) + 15, h - 5])
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
				square([w, h]);
				if (r != 0)
				{
					translate([0, 0])
						square([r, r]);
					translate([w - r, 0])
						square([r, r]);
					translate([0, h - r])
						square([r, r]);
					translate([w - r, h - r])
						square([r, r]);
				}
			}
			if (r != 0)
			{
				translate([r, r])
					circle(r);
				translate([w - r, r])
					circle(r);
				translate([r, h - r])
					circle(r);
				translate([w - r, h - r])
					circle(r);
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
		translate([10, 10])
			square([230, 90]);
		usb_cutout(250 / 2, 110, 20, 10);
	}
}

module closed()
{
	difference()
	{
		case(3);
		translate([10, 10])
			square([230, 90]);
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
		translate([10, 10])
			square([250 - 20, 110 - 30]);
	}
}

module switch_plate()
{
	difference()
	{
		case(3);
		translate([13.225, 13.225])
			switch_holes(12, 4);
	}
}

//switch_plate();
//open();
//top();
//bottom();
//closed();