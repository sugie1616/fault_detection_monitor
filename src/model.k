include "task.k"
//using konoha.posix.*;

class Model {

	Task parseFlow(String flow){
		Task task = new Task();
		String[] map;
		map = flow.split($/ +/);
		task.type = map[0];
		task.name = map[1];
		task.x    = (int)map[2];
		task.y    = (int)map[3];

		return task;
	}

	Task parseLog(String log){
		Task task = new Task();
		int secTime;
		String[] map, otherMap, appMap;
		String other, taskListName, taskName;
		map = log.split($/ +/);
		task.timestamp = map[0] + map[1] + map[2];
		secTime = (int)map[2].split($/:/)[0] * 3600 + (int)map[2].split($/:/)[1] * 60 + (int)map[2].split($/:/);
		print task.timestamp;
		print secTime;
		task.hostName = map[3];
		print task.hostName;
		task.pid = map[4];
		print task.pid;
		task.hashNumber = map[5];
		print task.hashNumber;
		task.applicationName = map[6];
		print task.applicationName;
		otherMap = map[7].split($/"/);
		print otherMap;
		int i = 0;
		appMap = task.applicationName.split($/_/);
		print appMap;
		if ( appMap[0] == "actor:new"){
			taskListName = otherMap[3].split($/_/)[1];
			print taskListName;
				task.name = task.name + otherMap[3].split($/_/)[2] + "_";
				task.name = task.name + otherMap[3].split($/_/)[3];
		}
		else if ( appMap[0] == "d-task" || appMap[0] == "d-script") {
			taskListName = appMap[1];
				task.name = task.name + appMap[2] + "_";
				task.name = task.name + appMap[3];
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
		return taskList;
	}
}

int main(){
	Model model = new Model();
	TaskList taskList = new TaskList();
	print "read flow file = ../resource/flows/monitorFlow";
	taskList = model.setTaskList("../resource/flows/monitorFlow");
	//print taskList;

	print "read log file = ../log/sampleLog2";
	InputStream ins = new InputStream("../log/sampleLog2");
	Task flashTask = new Task();
	String log;
	foreach (String log in ins){
		//flashTask = taskList.find(model.parseLog(log).name);
		//print "flash task = " + flashTask;
		flashTask = model.parseLog(log);
		System.sleep(1);
	}
}
