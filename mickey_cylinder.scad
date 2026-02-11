// Mickey Cylinder - Cylinder with center hole and two round ears
// Main body: 3mm diameter, 8mm height, 1mm center hole

$fn = 64; // Smooth circles

// Parameters
body_diameter = 3;    // Main cylinder diameter
body_height = 8;      // Main cylinder height
hole_diameter = 1;    // Center hole diameter
ear_diameter = 4;     // Ear diameter
ear_height = 2;       // Ear height (thickness)
ear_offset = -1;      // How far ears sit from center
edge_radius = 0.3;    // Radius for rounded edges

// Module for cylinder with rounded edges using hull of toruses
module rounded_cylinder(d, h, r) {
    if (r <= 0 || r > d/2 || r > h/2) {
        // Fallback to regular cylinder if radius invalid
        cylinder(d=d, h=h);
    } else {
        hull() {
            // Bottom torus
            translate([0, 0, r])
                rotate_extrude()
                    translate([d/2 - r, 0, 0])
                        circle(r=r);
            // Top torus
            translate([0, 0, h - r])
                rotate_extrude()
                    translate([d/2 - r, 0, 0])
                        circle(r=r);
        }
    }
}

difference() {
    union() {
        // Main body cylinder with rounded edges
        rounded_cylinder(d=body_diameter, h=body_height, r=edge_radius);
        
        // Left ear (rotated 90° to stick out horizontally on Y axis)
        translate([-ear_height/2, -body_diameter, body_height - ear_diameter/2 - ear_offset])
            rotate([90, 0, 90])
                rounded_cylinder(d=ear_diameter, h=ear_height, r=edge_radius);
        
        // Right ear (rotated 90° to stick out horizontally on Y axis)
        translate([-ear_height/2, body_diameter, body_height - ear_diameter/2 - ear_offset])
            rotate([-90, 0, -90])
                rounded_cylinder(d=ear_diameter, h=ear_height, r=edge_radius);
    }
    
    // Center hole through entire height
    translate([0, 0, -1])
        #cylinder(d=hole_diameter, h=body_height - 1);
}
