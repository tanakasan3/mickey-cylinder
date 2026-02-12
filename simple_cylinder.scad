// Simple Cylinder - Cylinder with center hole
// Main body: 3mm diameter, 8mm height, 1mm center hole

$fn = 64; // Smooth circles

// Parameters
body_diameter = 4;    // Main cylinder diameter
body_height = 8;      // Main cylinder height
hole_diameter = 2;    // Center hole diameter
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
        
        // Rounded dome on top
        translate([0, 0, body_height])
            sphere(d=body_diameter);
    }
    
    // Center hole through entire height (including dome)
    translate([0, 0, -1])
        #cylinder(d=hole_diameter, h=body_height + body_diameter/2 + 1);
}
