extern crate libc;
mod ffi;

use std::ptr;
use std::ffi::CString;
use std::ffi::c_void;
use libc::c_int;


pub struct MolochPlugin {
    name: CString
}

impl MolochPlugin {
    pub fn new(name: &str) -> MolochPlugin {
        MolochPlugin {
            name: CString::new(name).unwrap()
        }
    }
    pub fn moloch_plugins_set_cb<TcpHandler: 'static>(&mut self, tcp: TcpHandler)
        where TcpHandler: FnMut(&[u8]) {
        unsafe {
            ffi::moloch_plugins_set_cb(
                self.name.as_bytes() as *const _ as _,
                None,
                None,
                Some(moloch_plugin_tcp_func),
                Some(moloch_plugin_save_func),
                Some(moloch_plugin_save_func),
                None,
                None,
                None)
        }
    }

    pub fn moloch_plugins_register(&mut self, store_data: bool) -> u64 {
        unsafe {
            ffi::moloch_plugins_register_internal(
                self.name.as_bytes() as *const _ as _,
                store_data as _,
                std::mem::size_of::<ffi::moloch_session>() as _,
                ffi::MOLOCH_API_VERSION as _) as u64
        }
    }
}

#[no_mangle]
pub extern fn moloch_plugin_init() {
    println!("####  moloch_plugin_init()");
    let mut handle = MolochPlugin::new("hello_world");
    let num = handle.moloch_plugins_register(false);
    println!("####  moloch_plugins_register={}", num);
    handle.moloch_plugins_set_cb(|data| {});
    println!("####  moloch_plugin_init() exit")
}

#[no_mangle]
pub unsafe extern "C" fn moloch_plugin_tcp_func(session_ptr: *mut ffi::moloch_session, data: *const u8, len: i32, which: i32) {
    println!("#### MolochPluginTcpFunc {:?} {:?} {:?}", session_ptr, data, len);
    let session = &unsafe { *session_ptr };
    let tcp_data_head = session.tcpData;

    println!("#### data: {:?}", data);
    let rustdata = unsafe { std::slice::from_raw_parts(data, len as usize) };
    println!("#### {:?}", rustdata);
    println!("#### {:?}", std::str::from_utf8(rustdata));

    println!("#### tcp_data_head: {:?}", tcp_data_head);
    if !tcp_data_head.td_next.is_null() {
        handle_tcp_session(&tcp_data_head)
    }
    
}

#[no_mangle]
pub unsafe extern "C" fn moloch_plugin_save_func(session_ptr: *mut ffi::MolochSession_t, final_: ::std::os::raw::c_int) {
    /*let session = &unsafe { *session_ptr };
    let port1 = session.port1;
    let port2 = session.port2;

    let next = session;*/

    let mut ctr = 0;

    //#define DLL_FOREACH(name,head,element) \
    //  for ((element) = (head)->name##next; \
    //       (element) != (void *)(head); \
    //       (element)=(element)->name##next)

    println!("#### MolochPluginSaveFunc {:?} {:?}", session_ptr, final_);
    let first = session_ptr;
    let mut elem_ptr = first;
    loop {
        let elem = &unsafe { *elem_ptr };
        let tcp_data_head = elem.tcpData;

        println!("#### tcp_data_head: {:?}", tcp_data_head);
        if !tcp_data_head.td_next.is_null() {
            handle_tcp_session(&tcp_data_head)
        }

        elem_ptr = elem.tcp_next;
        if elem_ptr == first || elem_ptr.is_null() {
            break;
        }

        ctr += 1;
        if ctr > 100 {
            println!("#### emergency break out of session loop");
            break;
        }
    }

    
}

fn handle_tcp_session(data_head: &ffi::MolochTcpDataHead_t) {
    let tcp_packet_list = data_head;
    //let mut head = data_head.td_next;
    let mut next = data_head.td_next;
    let mut packet_ctr = 0;
    println!("#### Handling tcp sesh with list {:?}, td_count {:?}, next {:?}, ctr {:?}",
              tcp_packet_list, tcp_packet_list.td_count, next, packet_ctr);
    while !next.is_null() {
        let curr: &ffi::moloch_tcp_data = &unsafe { *next };
        println!("#### Pkg {:?} curr: {:?}", packet_ctr, curr);

        //Spass
        //let packet = &unsafe { *curr.packet };
        //let data = unsafe { std::slice::from_raw_parts(packet.pkt, packet.pktlen as usize) };

        //println!("#### {:?}", data);

        /*
moloch_1               | #### tcp_data_head: MolochTcpDataHead_t { td_next: 0x7effa0002078, td_prev: 0x7effa0002078, td_count: 0 }
moloch_1               | #### Handling tcp sesh with list MolochTcpDataHead_t { td_next: 0x7effa0002078, td_prev: 0x7effa0002078, td_count: 0 }, td_count 0, next 0x7effa0002078, ctr 0
moloch_1               | #### Pkg 0 curr: moloch_tcp_data { td_next: 0x7effa0002078, td_prev: 0x7effa0002078, packet: 0x0, seq: 706135497, ack: 4259645707, len: 514, dataOffset: 0 }
moloch_1               | #### proper end of linked list :) 
moloch_1               | #### MolochPluginSaveFunc 0x7effa0002c80 1
moloch_1               | #### tcp_data_head: MolochTcpDataHead_t { td_next: 0x7effa0002cf8, td_prev: 0x7effa0002cf8, td_count: 0 }
moloch_1               | #### Handling tcp sesh with list MolochTcpDataHead_t { td_next: 0x7effa0002cf8, td_prev: 0x7effa0002cf8, td_count: 0 }, td_count 0, next 0x7effa0002cf8, ctr 0
moloch_1               | #### Pkg 0 curr: moloch_tcp_data { td_next: 0x7effa0002cf8, td_prev: 0x7effa0002cf8, packet: 0x0, seq: 3187800689, ack: 172655247, len: 514, dataOffset: 0 }
moloch_1               | #### proper end of linked list :) 
        */

        next = curr.td_next;
        if next == data_head.td_next || next.is_null() {
            println!("#### proper end of linked list :) ");
            break;
        }
        packet_ctr += 1;

        if packet_ctr > 100 {
            println!("#### Safety kill triggered after 100 packets! :( I'am dead now 11ELF!!");
            break;
            //TODO: this is safety, remove later
        }
    }
}

fn handle_udp_session(session: &ffi::MolochSession_t) {
    
}



