
// int (*orig__ZN2GD17GDLibStartupLayer22checkPartialComplianceEv) ();
// int replaced__ZN2GD17GDLibStartupLayer22checkPartialComplianceEv ()
// {
// 	DDLogVerbose(@"[Good Dynamics - CPP] Jailbreak GDLibStartupLayer22checkPartialComplianceE");
// 	return 1;
// }

int (*orig__ZN2GD23PolicyComplianceChecker21checkComplianceLockedERNS_24PolicyComplianceRuleTypeE) (void *arg0);
int replaced__ZN2GD23PolicyComplianceChecker21checkComplianceLockedERNS_24PolicyComplianceRuleTypeE (void *arg0)
{
	DDLogVerbose(@"[Good Dynamics - CPP] Jailbreak PolicyComplianceChecker21checkComplianceLocked");
	return 0;
}

// int (*orig__ZN2GT19GeneralUtilityClass19constructStringListENS0_25tamper_detection_method_tESt6vectorISsSaISsEE) (void *arg0, void *arg1);
// int replaced__ZN2GT19GeneralUtilityClass19constructStringListENS0_25tamper_detection_method_tESt6vectorISsSaISsEE (void *arg0, void *arg1)
// {
// 	DDLogVerbose(@"[Good Dynamics - CPP] Jailbreak tamper_detection_method");
// 	return 0;
// }

// int (*orig__ZN2GD23PolicyComplianceChecker23checkComplianceUnlockedER6GDJson) (void *arg0);
// int replaced__ZN2GD23PolicyComplianceChecker23checkComplianceUnlockedER6GDJson (void *arg0)
// {
// 	DDLogVerbose(@"[Good Dynamics - CPP] Jailbreak PolicyComplianceChecker23checkComplianceUnlocked");
// 	return 0;
// }



int (*orig__ZN2GD23PolicyComplianceChecker22extractComplianceRulesER6GDJsonRSt6vectorINS_20PolicyComplianceRuleESaIS4_EE) (void *arg0, void *arg1, void *arg2);
int replaced__ZN2GD23PolicyComplianceChecker22extractComplianceRulesER6GDJsonRSt6vectorINS_20PolicyComplianceRuleESaIS4_EE (void *arg0, void *arg1, void *arg2)
{
	DDLogVerbose(@"[Good Dynamics - CPP] Jailbreak PolicyComplianceChecker23checkComplianceUnlocked");
	return 0;
}
