include "task.k"
//using konoha.posix.*;

class Model {

	Task parseFlow(String flow){
		Task task = new Task();
		String[] map;
		map = flow.split($/ +/);
		task.type = map[0];
		if (task.type == "SequenceFlow"){
			task.incoming = (int)map[1].split($/-/)[0];
			task.outgoing = (int)map[1].split($/-/)[1];
			}
		else if (task.type == "Setting"){
			task.x = (int)map[1];
			task.y = (int)map[2];
			}
		else {
			task.type = map[0];
			task.name = map[1];
			task.x = (int)map[2];
			task.y = (int)map[3];
			task.id = (int)map[4].split($/:/)[1];
			}

		return task;
	}

	Task parseLog(String log){
		Task task = new Task();
		int secTime;
		String[] map, otherMap, appMap;
		map = log.split($/ +/);
		task.timestamp = map[0] + map[1] + map[2];
		secTime = (int)map[2].split($/:/)[0] * 3600 + (int)map[2].split($/:/)[1] * 60 + (int)map[2].split($/:/)[2];
		task.hostName = map[3];
		task.pid = map[4];
		task.hashNumber = map[5];
		task.applicationName = map[6];
		otherMap = map[7].split("\"");
		appMap = task.applicationName.split($/_/);
		int size;
		if ( appMap[0] == "actor:new"){
			task.listName = otherMap[3].split($/_/)[1];
			size = otherMap[3].split($/_/).getSize();
			for (int i = 2; i < size; i ++) {
				if (i != size - 1) {
					task.name = task.name + otherMap[3].split($/_/)[i] + "_";
				}
				else if (i == size - 1){
					task.name = task.name + otherMap[3].split($/_/)[i];
				}
			}
			task.status = TASK_WORKING;
		}
		else if ( appMap[0] == "d-task" || appMap[0] == "d-script") {
			task.listName = appMap[1];
			size = appMap.getSize();
			for (int i = 2; i < size; i ++) {
				if (i != size - 1) {
					task.name = task.name + appMap[i] + "_";
				}
				else if (i == size - 1){
					task.name = task.name + appMap[i];
				}
			}
			task.status = TASK_WORKING;
		}
		print task;
		return task;
	}

	TaskList getTaskList(String filename){
		TaskList taskList = new TaskList();
		InputStream ins = new InputStream(filename);
		String flow;
		foreach (String flow in ins){
			taskList.add(parseFlow(flow));
		}
		//taskList.maxX = taskList[0].x;
		//taskList.maxY = taskList[0].y;
		return taskList;
	}
}

/*
int main(){
	Model model = new Model();
	TaskList monitorTaskList = new TaskList();
	monitorTaskList = model.getTaskList("../resource/flows/monitorFlow");
	TaskList diagnosisTaskList = new TaskList();
	diagnosisTaskList = model.getTaskList("../resource/flows/diagnosisFlow");
	TaskList recoverTaskList = new TaskList();
	recoverTaskList = model.getTaskList("../resource/flows/recoverFlow");
	
	//print monitorTaskList;
	//print diagnosisTaskList;
	//print recoverTaskList;

	InputStream ins = new InputStream("../log/sampleLog2");
	Task flashTask = new Task();
	Task tmpTask = new Task();
	String log;
	foreach (String log in ins){
		tmpTask = model.parseLog(log);
		if ( tmpTask.listName == "monitor"){
		flashTask = monitorTaskList.find(tmpTask.name);
		print flashTask;
		}
		else if ( tmpTask.listName == "diagnosis"){
		flashTask = diagnosisTaskList.find(tmpTask.name);
		print flashTask;
		}
		else if (tmpTask.listName == "recover") {
		flashTask = recoverTaskList.find(tmpTask.name);
		print flashTask;
		}
	}
	return 0;
}
*/
