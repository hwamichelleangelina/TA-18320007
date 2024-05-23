class ReqidStorage {
  static int reqid = 0;

  static void setReqid(int value) {
    reqid = value;
  }

  static int getReqid() {
    return reqid;
  }
}
