//include "controller.k"
//include "view.k"
include "task.k"
using konoha.posix.*;

class Model {

	Task parseFlow(String flow){
		Task task = new Task();
		String[] map;
		map = flow.split($/ +/);
		task.type = map[0];
		task.name = map[1];
		task.x = (int)map[2];
		task.y = (int)map[3];

		return task;
	}

	Task parseLog(String log){
		Task task = new Task();
		String[] map;
		map = log.split($/ +/);
		task.name = map[0];

		return task;
	}

//	String parseSampleLog(String log){
//		String[] map;
//		map = log.split($/ +/);
//	
//	}

	TaskTable setTaskTable(String filename){
		TaskTable taskTable = new TaskTable();
		InputStream ins = new InputStream(filename);
		String flow;
		foreach (String flow in ins){
			taskTable.add(parseFlow(flow));
		}
		return taskTable;
	}
}

int main(){
	Model model = new Model();
	TaskTable taskTable = new TaskTable();
	print "read flow file = ../resource/flows/monitorFlow";
	taskTable = model.setTaskTable("../resource/flows/monitorFlow");
	print taskTable;

	print "read log file = ../log/sampleLog";
	InputStream ins = new InputStream("../log/sampleLog");
	Task flashTask = new Task();
	String log;
	foreach (String log in ins){
		flashTask = taskTable.find(model.parseLog(log).name);
		print "flash task = " + flashTask;
		System.sleep(1);
	}
}
