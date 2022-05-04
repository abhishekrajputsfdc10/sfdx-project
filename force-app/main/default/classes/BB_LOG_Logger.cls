/*************************************************************************************************************************
@ Class : BB_LOG_Logger
@ author: Jay
@ date: Mar-03-2020  
Description: This class us used for logs
These logs are controlled from Custom setting where user should be enabled else it will not print the logs.
Usage : BB_LOG_Logger.Logger().Log('Message'); or 
BB_LOG_Logger.Logger().Log(exception);
*************************************************************************************************************************/
public class BB_LOG_Logger {
    @testVisible
    private static Boolean overrideIsTest = false;
    @testVisible
    //private static Boolean enabledForCurUser=DebugLogSetting__c.getInstance(userinfo.getUserId()).Enable__c;
    private static Boolean enabledForCurUser=true;
    //system.debug(userinfo.getUserId());
    public enum LogLevel {NONE, ERROR, WARN, INFO, DEBUG, FINE, FINER, FINEST,INTERNAL}

    public class LoggerException extends Exception {}

    public interface Logger {
        void log();
        void log(LogLevel level);
        void log(Object message);
        void log(String message);
        void log(String title, Object message);
        void log(Exception ex);
        Logger message(Object message);
        Logger message(String message);
        Logger param(Object param);
    }

    private static Logger instance;
    public static Logger logger() {
        if (instance == null ) {
            instance = new SimpleLogger();
        }

        return instance;
    }

    private class LogMessage {
        private List<String> messages;
        private List<Object> params;

        private LogMessage(String message) {
            this.messages = new List<String> {message};
        }

        public void message(String message) {
            this.messages.add(message);
        }

        public void message(Object message) {
            this.message(JSON.serializePretty(message));
        }

        public void param(Object param) {
            if (params == null) {
                params = new List<Object>();
            }

            params.add(param);
        }

        public override String toString() {
            String msg;
            Integer paramNum = 0;
            for (String message : messages) {
                if (msg != null) {
                    msg += '\n' + message;
                } else {
                    msg = message;
                }
            }

            if (params != null) {
                for (Object param : params) {
                    msg = msg.replace(':p' + paramNum, param != null ? String.valueOf(param) : 'NULL');
                    paramNum++;
                }
            }

            return msg;
        }
    }

    private class SimpleLogger implements Logger {
        private List<LogMessage> messages;
        private LogMessage currentMessage;

        private SimpleLogger() {
            messages = new List<LogMessage>();
        }

        public void log() {
            if (currentMessage != null && enabledForCurUser) {
                System.debug(currentMessage.toString());
            }

            // save message so it can be inspected in tests
            if (!isTest()) {
                messages.clear();
            }
            currentMessage = null;
        }

        public void log(LogLevel level) {
            if (currentMessage != null && enabledForCurUser) {
                System.debug(BB_LOG_Logger.getSystemLoggingLevel(level), currentMessage.toString());
            }

            // save message so it can be inspected in tests
            if (!isTest()) {
                messages.clear();
            }
            currentMessage = null;
        }

        public void log(String title, String message) {
            if (title != null) {
                message = title + ': ' + message;
            }

            if (currentMessage != null && enabledForCurUser) {
                System.debug(currentMessage.toString());
            }

            // save message so it can be inspected in tests
            if (isTest()) {
                if (currentMessage == null) {
                    messages.add(new LogMessage(message));
                } else {
                    currentMessage.message(message);
                }
            } else {
                messages.clear();
            }

            currentMessage = null;
            if(enabledForCurUser)
            System.debug(message);
        }

        public void log(String title, Object message) {
            log(title, JSON.serializePretty(message));
        }

        public void log(Object message) {
            log(null, JSON.serializePretty(message));
        }

        public void log(String message) {
            log(null, message);
        }

        public void log(Exception ex) {
            if (currentMessage != null && enabledForCurUser) {
                System.debug(System.LoggingLevel.ERROR, currentMessage.toString());
            }

            // save message so it can be inspected in tests
            if (isTest()) {
                if (messages.size() == 0) {
                    messages.add(new LogMessage(String.valueOf(ex)));
                } else {
                    messages.get(0).message(String.valueOf(ex));
                }
            } else {
                messages.clear();
            }

            currentMessage = null;

            log(LogLevel.ERROR);
            if(enabledForCurUser){
                System.debug(ex);
                System.debug('Current line: ' + ex.getLineNumber());
                System.debug(ex.getStackTraceString());
            }
            
        }

        public Logger message(String message) {
            if (currentMessage == null) {
                currentMessage = new LogMessage(message);
                messages.add(currentMessage);
            } else {
                currentMessage.message(message);
            }
            return this;
        }

        public Logger message(Object message) {
            return message(JSON.serializePretty(message));
        }

        public Logger param(Object param) {
            if (currentMessage == null) {
                throw new LoggerException('No message configured');
            }

            currentMessage.param(param);
            return this;
        }

        private void clear() {
            currentMessage = null;
            messages.clear();
        }

        private List<String> getLogMessages() {
            List<String> logMessages = new List<String>();
            for (LogMessage message : messages) {
                logMessages.add(message.toString());
            }

            return logMessages;
        }

        private Boolean isTest() {
            return !overrideIsTest && Test.isRunningTest();
        }
    }

    private static Map<String, System.LoggingLevel> systemLogLevels;
    private static System.LoggingLevel getSystemLoggingLevel(LogLevel level) {
        if (systemLogLevels == null) {
            systemLogLevels = new Map<String, System.LoggingLevel>();
            for (System.LoggingLevel sl: System.LoggingLevel.values()) {
                systemLogLevels.put(sl.name(), sl);
            }
        }

        return systemLogLevels.get(level.name());
    }

    @testVisible
    private static List<String> logMessages() {
        return instance == null ? null : ((SimpleLogger) instance).getLogMessages();
    }

    @testVisible
    private static void clearLogMessages() {
        if (instance != null) ((SimpleLogger) instance).clear();
    }
}