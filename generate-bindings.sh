#!/bin/sh
bindgen --size_t-is-usize moloch.h -o tmp.rs -- -Ithirdparty -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include/ -I/usr/lib/glib-2.0/include/
cat << EOF > bindings.rs
#![allow(non_upper_case_globals)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]
#![allow(dead_code)]
EOF
cat tmp.rs >> bindings.rs
rm tmp.rs
