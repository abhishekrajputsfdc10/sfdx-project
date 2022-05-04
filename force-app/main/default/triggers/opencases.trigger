trigger opencases on Account (before update) {
    CaseMasterTriggerhandler.openCaseCount(trigger.new);
}