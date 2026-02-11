// Mickey Cylinder - Cylinder with center hole and two round ears
// Main body: 3mm diameter, 8mm height, 1mm center hole

$fn = 64; // Smooth circles

// Parameters
body_diameter = 3;    // Main cylinder diameter
body_height = 8;      // Main cylinder height
hole_diameter = 1;    // Center hole diameter
ear_diameter = 2;     // Ear diameter
ear_height = 1.5;     // Ear height (thickness)
ear_offset = 0.8;     // How far ears sit from center

difference() {
    union() {
        // Main body cylinder
        cylinder(d=body_diameter, h=body_height);
        
        // Left ear (rotated 90° to stick out horizontally on Y axis)
        translate([0, -body_diameter/2, body_height - ear_diameter/2 - ear_offset])
            rotate([90, 0, 0])
                cylinder(d=ear_diameter, h=ear_height);
        
        // Right ear (rotated 90° to stick out horizontally on Y axis)
        translate([0, body_diameter/2, body_height - ear_diameter/2 - ear_offset])
            rotate([-90, 0, 0])
                cylinder(d=ear_diameter, h=ear_height);
    }
    
    // Center hole through entire height
    translate([0, 0, -1])
        cylinder(d=hole_diameter, h=body_height + 2);
}
