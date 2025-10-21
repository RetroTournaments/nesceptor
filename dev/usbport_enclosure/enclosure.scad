pcb_length = 35;
pcb_width = 12;
pcb_hole = 18;
pcb_thickness = 1.6;

module rounded_rect(uw, uh, ul, ur, fn) {
    union() {
        translate([ur, ur, 0]) {
            cylinder(h=ul, r=ur, center=false, $fn=fn);
        }
        translate([uw-ur, ur, 0]) {
            cylinder(h=ul, r=ur, center=false, $fn=fn);
        }
        translate([ur, uh-ur, 0]) {
            cylinder(h=ul, r=ur, center=false, $fn=fn);
        }
        translate([uw-ur, uh-ur, 0]) {
            cylinder(h=ul, r=ur, center=false, $fn=fn);
        }
        translate([0, ur, 0]) {
            cube([uw, uh-2*ur, ul]);
        }
        translate([ur, 0, 0]) {
            cube([uw-2*ur, uh, ul]);
        }
    }
}

module usbport() {
    // The PCB
    difference() {
        cube([pcb_length, pcb_width, pcb_thickness]);
        
        translate([pcb_hole, 6, 0.8]) {
            cylinder(h=4, d=3.2, center=true, $fn=16);
        }
    }
    
    // The USB C Port
    uw = 8.94;
    translate([-1, (pcb_width-uw)/2, pcb_thickness]) {
        rotate([90, 0, 90]) {
            rounded_rect(uw, 3.26, 7.35, (3.26 - 0.7) / 2, 16);
        }
    }
    
}


module nes_bottom() {
    nw = 270;
    nl = 240;
    nh = 50;
    difference() {
        // The full bottom
        cube([nl, nw, nh]);
        
        // The 2 degree tapers on the front and back
        translate([0, -5, nh]) {
            mirror([1, 0, 0]) {
                rotate([0, 92, 0]) {
                    cube([55, nw+10, 10]);
                }
            }
        }
        translate([nl, -5, nh]) {
            rotate([0, 92, 0]) {
                cube([55, nw+10, 10]);
            }
        }
        
        // the 22 degree tapers on the left and right
        translate([-5, 0, nh-12]) {
            mirror([0, 0, 1]) {
                rotate([68, 0, 0]) {
                    cube([nl+10, 50, 25]);
                }
            }
        }
        translate([-5, nw, nh-12]) {
            mirror([0, 0, 0]) {
                rotate([68+180, 0, 0]) {
                    cube([nl+10, 50, 25]);
                }
            }
        }
        
        // the bottom slot
        hull() {
            translate([0, 101, -0.1]) {
                cube([100, 16.5, 0.1]);
                translate([0, 0.25, 12.6]) {
                    cube([100, 16, 0.1]);
                }
            }
        }
    }
}


// Approx outer box dimensions
enc_length = 40;
enc_width = 15;
enc_height = 11.5;

// Inner box dimensions
wall_size = 1.2; // front and back
// width uses 'pcb_width'
pcb_off = 0.15;
inner_width = pcb_width + pcb_off * 2;
pcb_ledge = 1;
ledge_width = pcb_width - pcb_ledge * 2;

pcb_height = 4;

module threaded_insert() {
    h = 4;
    v = tan(8) * h;
    cylinder(h=h, r1=2.525 + v/2, r2=2.525 - v/2, $fn=30);
}

cut_height = enc_height *3/4;

module enc() {
    // distance to expand top of box forward to match the slight NES angle
    front_off = 0.4;
    // distance to shrink top inwards to match the NES angle
    top_off = 0.5;
    
    // outside boundary
    difference() {
        union() {
            difference() {
                // the main outside area
                hull() {
                    cube([enc_length, enc_width, 0.001]);
                    translate([-front_off, top_off / 2, enc_height]) {
                        cube([enc_length + front_off, enc_width-top_off, 0.001]);
                    }
                }
                // Upper inner section
                translate([wall_size, (enc_width-inner_width) / 2, pcb_height]) {
                    cube([enc_length-wall_size*2, inner_width, enc_height-(pcb_height + wall_size)]);
                }
                // Lower inner section
                translate([wall_size, (enc_width-ledge_width) / 2, wall_size]) {
                    cube([enc_length-wall_size*2, ledge_width, enc_height-(pcb_height + wall_size)]);
                }

                // The front usb port
                uw = 9.2;
                uh = 3.4;
                translate([-1, (enc_width-uw)/2, pcb_height + pcb_thickness]) {
                    rotate([90, 0, 90]) {
                        rounded_rect(uw, uh, 7.35, (uh - 0.8) / 2, 30);
                    }
                }
                // The back port
                bw = 6;
                bh = 2;
                translate([enc_length-wall_size - 1, (enc_width-bw)/2,
                    cut_height - bh/2 + -0.2]) {
                    rotate([90, 0, 90]) {
                        rounded_rect(bw, bh, 7.35, bh / 2, 30);
                    }
                }
            }
            
            // under pcb hole support
            support_r = 4.5;
            translate([pcb_hole + wall_size, enc_width/2, 0]) {
                cylinder(h=pcb_height, r=support_r, center=false, $fn=120);
            }
            
            // above pcb threaded insert
            translate([pcb_hole + wall_size, enc_width/2, pcb_height + pcb_thickness]) {
                difference() {
                    cylinder(h=enc_height - pcb_height - pcb_thickness, r=support_r, center=false, $fn=120);
                    translate([0, 0, -0.001]) {
                        threaded_insert();
                    }
                }
            }
            
        }
        // The slot for the screw head
        translate([pcb_hole + wall_size, enc_width/2, -0.1]) {
            cylinder(h=3.1, r=3, $fn=120);
        }
        // The screw hole
        translate([pcb_hole + wall_size, enc_width/2, -0.1]) {
            cylinder(h=pcb_height + 0.2, r=1.6, $fn=120);
        }
    }
}

module cutter() {
    union() {
        // The main split into two
        translate([wall_size+0.001, -10, cut_height]) {
            cube([enc_length, enc_width+20, enc_height]);
        }
        
        // cut out for a kinda snap together lip? maybe too thin
        /*
        translate([wall_size + 0.001, wall_size / 2 + 0.3, enc_height * 3/4 - 0.4]){
            cube([enc_length - wall_size * 2 + wall_size * 0.5, 
            enc_width - wall_size - 0.6, 10]);
        }
        */
        
        // to support the above pcb threaded insert
        translate([pcb_hole + wall_size - 5, enc_width/2 - 5, pcb_height + pcb_thickness / 2]) {
            cube(10);
        }
    }
}

/*
rotate([-90, 0, 0]) {
*/

//translate([wall_size, (enc_width-pcb_width) / 2, pcb_height]) usbport();
//translate([-1.8, -101.7, 0]) nes_bottom();

/*
translate([0, 40, enc_height]) {
    rotate([180, 0, 0]) {
        intersection() {
            enc();
            cutter();
        }
    }
}
*/

difference() {
    enc();
    cutter();
}


//cutter();
/*
}
*/