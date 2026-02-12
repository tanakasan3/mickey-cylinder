// Simple Cylinder - Cylinder with center hole
// Main body: 3mm diameter, 8mm height, 1mm center hole

$fn = 64; // Smooth circles

// Parameters
body_diameter = 4;    // Main cylinder diameter
body_height = 8;      // Main cylinder height
hole_diameter = 2;    // Center hole diameter
edge_radius = 0.3;    // Radius for rounded edges

// Module for cylinder with rounded bottom edge only (flat top)
module rounded_bottom_cylinder(d, h, r) {
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
            // Top circle (flat edge)
            translate([0, 0, h - 0.01])
                cylinder(d=d, h=0.01);
        }
    }
}

difference() {
    union() {
        // Main body cylinder with rounded bottom edge (flat top)
        rounded_bottom_cylinder(d=body_diameter, h=body_height, r=edge_radius);
        
        // Rounded dome on top (solid, no hole)
        translate([0, 0, body_height])
            sphere(d=body_diameter);
    }
    
    // Center hole stops at top of cylinder (doesn't go through dome)
    translate([0, 0, -1])
        #cylinder(d=hole_diameter, h=body_height + 1);
}
