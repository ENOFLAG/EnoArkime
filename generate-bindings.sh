#!/bin/sh
bindgen moloch.h -o bindings.rs -- -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include/
sed -i.old '1s;^;#![allow(non_upper_case_globals)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]
#![allow(dead_code)]
;' bindings.rs
