using konoha.qt4.*;

class LogParser {

	int getBracketPoint(String log, String bracket, int brcount);

	String getTaskType(String log);
	String getTaskName(String log);
	String getTaskWork(String log);
	String getTaskTime(String log);

	LogParser(){

	}

	int getBracketPoint(String log, String bracket, int brcount){
		int i = 0;
		int br = 0;

		while (br != brcount){
			if (log[i] == bracket){
				br++;
			}
			i++;
		} if (br != 0)
			return i;
		else {
			return 0;
		}
	}

	String getTaskType(String log){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(log, "(", 1);
		rbrpoint = getBracketPoint(log, ")", 1);
		i = lbrpoint;
		String taskType = "";
		while (i != rbrpoint - 1){
			taskType = taskType + log[i];
			i++;
		}
		return taskType;
	}

	String getTaskName(String log){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(log, "(", 2);
		rbrpoint = getBracketPoint(log, ")", 2);
		i = lbrpoint;
		String taskName = "";
		while (i != rbrpoint - 1){
			taskName = taskName + log[i];
			i++;
		}
		return taskName;
	}

	String getTaskWork(String log){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(log, "(", 3);
		rbrpoint = getBracketPoint(log, ")", 3);
		i = lbrpoint;
		String taskWork = "";
		while (i != rbrpoint - 1){
			taskWork = taskWork + log[i];
			i++;
		}
		return taskWork;
	}

	String getTaskTime(String log){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(log, "(", 4);
		rbrpoint = getBracketPoint(log, ")", 4);
		i = lbrpoint;
		String taskTime = "";
		while (i != rbrpoint - 1){
			taskTime = taskTime + log[i];
			i++;
		}
		return taskTime;
	}
};
