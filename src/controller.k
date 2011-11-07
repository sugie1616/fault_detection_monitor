include "model.k"
//include "view.k"

class Controller {

	void run(){
		Model model = new Model();
		TaskList monitorTaskList = new TaskList();
		TaskList diagnosisTaskList = new TaskList();
		TaskList recoverTaskList = new TaskList();

		monitorTaskList = model.setTaskList("../resource/flows/monitorFlow");
		diagnosisTaskList = model.setTaskList("../resource/flows/diagnosisFlow");
		recoverTaskList = model.setTaskList("../resource/flows/recoverFlow");
		print monitorTaskList;
	}

	String getLog(){
	
	}

	void pressedTask(){
	
	}
}
