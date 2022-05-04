trigger checkDebug on Account (after insert, after update, before delete) {
    if(trigger.isInsert || trigger.isUpdate) {
        DebugClass.testDebug(trigger.new);
    }
    if(trigger.isDelete) {
        DebugClass.preventDelete(trigger.old);
    }
}