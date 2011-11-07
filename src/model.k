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

	TaskList setTaskList(String filename){
		TaskList taskList = new TaskList();
		InputStream ins = new InputStream(filename);
		String flow;
		foreach (String flow in ins){
			taskList.add(parseFlow(flow));
		}
		return taskList;
	}
}

//int main(){
//	Model model = new Model();
//	TaskList taskList = new TaskList();
//	print "read flow file = ../resource/flows/monitorFlow";
//	taskList = model.setTaskList("../resource/flows/monitorFlow");
//	//print taskList;
//
//	print "read log file = ../log/sampleLog";
//	InputStream ins = new InputStream("../log/sampleLog");
//	Task flashTask = new Task();
//
//	String log;
//	foreach (String log in ins){
//		flashTask = taskList.find(model.parseLog(log).name);
//		print "flash task = " + flashTask;
//		System.sleep(1);
//	}
//}
