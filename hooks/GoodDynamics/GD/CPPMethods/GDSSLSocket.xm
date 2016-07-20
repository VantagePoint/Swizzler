/*
 File Description:
  
  *************************
  ** GD CPP Method hooks **
  *************************
*/

// int GD::SslSocket::verify_certificate()()
int (*orig__ZN2GD9SslSocket18verify_certificateEv) ();
int replaced__ZN2GD9SslSocket18verify_certificateEv ()
{
  int ret = orig__ZN2GD9SslSocket18verify_certificateEv();
  DDLogVerbose(@"[Good Dynamics - CPP] GD::SslSocket::verify_certificate(): %d", ret);
  return ret;
}