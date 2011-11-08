include "model.k"
include "viewer.k"
using konoha.posix.*;

//String logfile = "/var/log/syslog"
String logfile = "../log/sampleLog2";

class Controller {

	Model model;
	Viewer viewer;
	
	TaskList monitorTaskList;
	TaskList diagnosisTaskList;
	TaskList recoverTaskList;
	
	
	Controller() {
		model = new Model();
		viewer = new Viewer();
		monitorTaskList = new TaskList();
		diagnosisTaskList = new TaskList();
		recoverTaskList = new TaskList();
		init();
	}

	void init(){
		monitorTaskList = model.getTaskList("../resource/flows/monitorFlow");
		diagnosisTaskList = model.getTaskList("../resource/flows/diagnosisFlow");
		recoverTaskList = model.getTaskList("../resource/flows/recoverFlow");
		viewer.visualizeFlow(monitorTaskList);
		viewer.visualizeFlow(diagnosisTaskList);
		//viewer.visualizeFlow(recoverTaskList);
	}
	
	void run() {
		Task task;
		InputStream ins = new InputStream(logfile);
		foreach(String str in ins) {
			//print str;
			task = model.parseLog(str);
			if (task.status != TASK_STOP) {
				//System.sleep(5);
				print "flash task = " + task;
				viewer.flash(task);
			}
		}
	}

	String getLog(){
		return "";
	}

	void pressedTask() {
	
	}
}

/*
void main() 
{
	QApplication app = new QApplication();
	Controller ctl = new Controller();
	ctl.run();
	app.exec();
}
*/
