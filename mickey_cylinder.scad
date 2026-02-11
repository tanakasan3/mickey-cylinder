// Mickey Cylinder - Cylinder with center hole and two round ears
// Main body: 3mm diameter, 8mm height, 1mm center hole

$fn = 64; // Smooth circles

// Parameters
body_diameter = 3;    // Main cylinder diameter
body_height = 8;      // Main cylinder height
hole_diameter = 1;    // Center hole diameter
ear_diameter = 1.5;   // Ear diameter
ear_height = 2;       // Ear height (thickness)
ear_offset = 0.8;     // How far ears sit from center

difference() {
    union() {
        // Main body cylinder
        cylinder(d=body_diameter, h=body_height);
        
        // Left ear
        translate([-body_diameter/2 - ear_offset + ear_diameter/2, 0, body_height - ear_height])
            cylinder(d=ear_diameter, h=ear_height);
        
        // Right ear
        translate([body_diameter/2 + ear_offset - ear_diameter/2, 0, body_height - ear_height])
            cylinder(d=ear_diameter, h=ear_height);
    }
    
    // Center hole through entire height
    translate([0, 0, -1])
        cylinder(d=hole_diameter, h=body_height + 2);
}
