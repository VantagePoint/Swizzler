/*
 File Description:
  
  *************************
  ** GD CPP Method hooks **
  *************************
*/
// int GD::PolicyProcessor::processLockAction(GD::PolicyRecord const&)(void * arg0)
int (*orig__ZN2GD15PolicyProcessor17processLockActionERKNS_12PolicyRecordE) (void *arg1);
int replaced__ZN2GD15PolicyProcessor17processLockActionERKNS_12PolicyRecordE (void *arg1)
{
	DDLogVerbose(@"[Good Dynamics - CPP] GD::PolicyProcessor::processLockAction and returning 0");
	return 0;
}


// int GD::PolicyProcessor::processWipeAction(GD::PolicyRecord const&)(void * arg0)
int (*orig__ZN2GD15PolicyProcessor17processWipeActionERKNS_12PolicyRecordE) (void *arg1);
int replaced__ZN2GD15PolicyProcessor17processWipeActionERKNS_12PolicyRecordE (void *arg1)
{
	DDLogVerbose(@"[Good Dynamics - CPP] GD::PolicyProcessor::processWipeAction and returning 0");
	return 0;
}


// int GD::PolicyProcessor::handleWipe(GD::PolicyComplianceRuleType)(void arg0)
int (*orig__ZN2GD15PolicyProcessor10handleWipeENS_24PolicyComplianceRuleTypeE) (void *arg1);
int replaced__ZN2GD15PolicyProcessor10handleWipeENS_24PolicyComplianceRuleTypeE (void *arg1)
{
	DDLogVerbose(@"[Good Dynamics - CPP] GD::PolicyProcessor::handleWipe and returning 0");
	return 0;
}


// int GD::PolicyCommandHandler::handleWipeAction(GDJson*)(void * arg0)
int (*orig__ZN2GD20PolicyCommandHandler16handleWipeActionEP6GDJson) (void *arg1);
int replaced__ZN2GD20PolicyCommandHandler16handleWipeActionEP6GDJson (void *arg1)
{
	DDLogVerbose(@"[Good Dynamics - CPP] GD::PolicyCommandHandler::handleWipeAction and returning 0");
	return 0;
}


// int GD::GDCTPHandler::wipeContainer(GD::WIPE_REASON)(void arg0)
int (*orig__ZN2GD12GDCTPHandler13wipeContainerENS_11WIPE_REASONE) (void *arg1);
int replaced__ZN2GD12GDCTPHandler13wipeContainerENS_11WIPE_REASONE (void *arg1)
{
	DDLogVerbose(@"[Good Dynamics - CPP] GD::GDCTPHandler::wipeContainer and returning 0");
	return 0;
}






