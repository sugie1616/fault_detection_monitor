include "model.k"
include "viewer.k"

class Controller {

	void run(){
		Model model = new Model();
		Viewer v = new Viewer();
		TaskList monitorTaskList = new TaskList();
		TaskList diagnosisTaskList = new TaskList();
		TaskList recoverTaskList = new TaskList();

		monitorTaskList = model.setTaskList("../resource/flows/monitorFlow");
		diagnosisTaskList = model.setTaskList("../resource/flows/diagnosisFlow");
		recoverTaskList = model.setTaskList("../resource/flows/recoverFlow");
		//print monitorTaskList;
		v.parseFlow(monitorTaskList);
	}

	String getLog() {
		return "";
	}

	void pressedTask() {
	
	}
}
