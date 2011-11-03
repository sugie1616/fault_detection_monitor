using konoha.qt4.*;

class FlowParser {

	int getBracketPoint(String flow, String bracket, int brcount);

	String getTaskType(String flow);
	String getTaskName(String flow);
	String getTaskWork(String flow);
	int getTaskPosX(String flow);
	int getTaskPosY(String flow);

	FlowParser(){

	}

	int getBracketPoint(String flow, String bracket, int brcount){
		int i = 0;
		int br = 0;

		while (br != brcount){
			if (flow[i] == bracket){
				br++;
			}
			i++;
		} if (br != 0)
			return i;
		else {
			return 0;
		}
	}

	String getTaskType(String flow){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(flow, "(", 1);
		rbrpoint = getBracketPoint(flow, ")", 1);
		i = lbrpoint;
		String taskType = "";
		while (i != rbrpoint - 1){
			taskType = taskType + flow[i];
			i++;
		}
		return taskType;
	}

	String getTaskName(String flow){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(flow, "(", 2);
		rbrpoint = getBracketPoint(flow, ")", 2);
		i = lbrpoint;
		String taskName = "";
		while (i != rbrpoint - 1){
			taskName = taskName + flow[i];
			i++;
		}
		return taskName;
	}

	String getTaskWork(String flow){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(flow, "(", 3);
		rbrpoint = getBracketPoint(flow, ")", 3);
		i = lbrpoint;
		String taskWork = "";
		while (i != rbrpoint - 1){
			taskWork = taskWork + flow[i];
			i++;
		}
		return taskWork;
	}

	int getTaskPosX(String flow){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(flow, "(", 4);
		rbrpoint = getBracketPoint(flow, ")", 4);
		i = lbrpoint;
		String x;
		while (i != rbrpoint - 1){
			x = x + flow[i];
			i++;
		}
		return (int)x;
	}

	int getTaskPosY(String flow){
		int i;
		int lbrpoint;
		int rbrpoint;
		lbrpoint = getBracketPoint(flow, "(", 5);
		rbrpoint = getBracketPoint(flow, ")", 5);
		i = lbrpoint;
		String y;
		while (i != rbrpoint - 1){
			y = y + flow[i];
			i++;
		}
		return (int)y;
	}
};
