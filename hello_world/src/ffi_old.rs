use std::ffi::c_void;
use std::os::raw::c_int;
use std::os::raw::c_char;
use libc::timeval;
use libc::in6_addr;

//pub type MolochPluginTcpFunc = *const Fn(*const c_void, *const c_void, c_int);

extern {
    pub fn moloch_plugins_set_cb(
        name: *const c_void,
        ipFunc: *const c_void,
        udpFunc: *const c_void,
        tcpFunc: *const c_void,
        preSaveFunc: *const c_void,
        save_func: *const c_void,
        newFunc: *const c_void,
        exitFunc: *const c_void,
        reloadFunc: *const c_void);

    pub fn moloch_plugins_register(
        name: *const c_char,
        storeData: c_int) -> c_int;
}

#[repr(C)]
struct tcp_data_head {
    _a: *const c_void,
    _b: *const c_void,
    _c: c_int
}
// typedef struct {
    //     int td_count;
//     struct moloch_tcp_data *td_next, *td_prev;

// } MolochTcpDataHead_t;


#[repr(C)]
struct moloch_session {
    tcp_next: *const c_void,
    tcp_prev: *const c_void,
    q_next: *const c_void,
    q_prev: *const c_void,
    h_next: *const c_void,
    h_prev: *const c_void,
    h_bucket: c_int,
    h_hash: u32,
    sessionId: [u8; 37],
    MolochField_t: *const c_void,
    pluginData: *const c_void,
    parserInfo: *const c_void,
    tcpData: tcp_data_head,
    tcpSeq: [u32; 2],
    tcpState: [u8; 2],

    filePosArray: *const c_void,
    fileLenArray: *const c_void,
    fileNumArray: *const c_void,
    rootId: u8,

    firstPacket: timeval,
    lastPacket: timeval,
    addr1: in6_addr,
    addr2: in6_addr,
    //char                   firstBytes[2][8];

    bytes: [u64; 2],
    databytes: [u64; 2],
    totalDatabytes: [u64; 2],

    lastFileNum: u32,
    saveTime: u32,
    packets: [u32; 2],
    synTime: u32,
    ackTime: u32,

    port1: u16,
    port2: u16,
    outstandingQueries: u16,
    segments: u16,
    stopSaving: u16,
    tcpFlagCnt: [u16; 9], //MOLOCH_TCPFLAG_MAX
    maxFields: u16,

    consumed: [u8; 2],
    ipProtocol: u8,
    mProtocol: u8,
    firstBytesLen: [u8; 2],
    ip_tos: u8,
    tcp_flags: u8,
    parserLen: u8,
    parserNum: u8,
    minSaving: u8,
    thread: u8,

    flags: u32
}